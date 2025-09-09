#!/bin/bash

# Dotfiles installation script
# This script sets up a new machine with the dotfiles configuration

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    error "This script is designed for macOS"
    exit 1
fi

info "Starting dotfiles installation..."

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    info "Homebrew is already installed"
fi

# Install GNU Stow if not already installed
if ! command -v stow &> /dev/null; then
    info "Installing GNU Stow..."
    brew install stow
else
    info "GNU Stow is already installed"
fi

# Install Oh My Zsh if not already installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    info "Oh My Zsh is already installed"
fi

# Install Powerlevel10k theme if not already installed
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
    info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    info "Powerlevel10k theme is already installed"
fi

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
info "Dotfiles directory: $DOTFILES_DIR"

# Function to backup existing files
backup_if_exists() {
    local file="$1"
    if [[ -f "$file" ]] || [[ -L "$file" ]]; then
        warn "Backing up existing $file to $file.backup"
        mv "$file" "$file.backup"
    fi
}

# Function to stow a package
stow_package() {
    local package="$1"
    info "Setting up $package..."
    
    cd "$DOTFILES_DIR"
    
    # Remove existing files/symlinks that would conflict
    case "$package" in
        "shell")
            backup_if_exists "$HOME/.zshrc"
            backup_if_exists "$HOME/.bashrc"
            backup_if_exists "$HOME/.bash_profile"
            backup_if_exists "$HOME/.p10k.zsh"
            ;;
        "git")
            backup_if_exists "$HOME/.gitconfig"
            ;;
        "ssh")
            backup_if_exists "$HOME/.ssh/config"
            ;;
        "config")
            # Handle .config directory items individually if needed
            ;;
    esac
    
    # Use stow to create symlinks
    stow -t "$HOME" "$package" || {
        error "Failed to stow $package"
        return 1
    }
}

# Install packages using stow
info "Creating symlinks with GNU Stow..."

# Stow each package
for package in shell git ssh config; do
    if [[ -d "$DOTFILES_DIR/$package" ]]; then
        stow_package "$package"
    else
        warn "Package $package not found, skipping..."
    fi
done

# Set up SSH permissions
if [[ -f "$HOME/.ssh/config" ]]; then
    info "Setting up SSH permissions..."
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh/config"
fi

# Reload shell configuration
info "Installation complete!"
info "Please restart your terminal or run 'source ~/.zshrc' to apply changes."

# Optional: Install common packages
read -p "Would you like to install common development packages? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    info "Installing common packages..."
    brew install git tree wget curl jq htop
fi

info "Dotfiles setup completed successfully!"
info "Remember to:"
info "  1. Restart your terminal"
info "  2. Configure any personal settings"
info "  3. Set up your Git user information if needed"