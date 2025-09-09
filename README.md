# 🏠 My Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/), following the approach outlined in [Atlassian's dotfiles tutorial](https://www.atlassian.com/git/tutorials/dotfiles).

## 📁 Structure

```
dotfiles/
├── config/           # XDG config directory files
│   └── .config/
│       └── git/
├── git/              # Git configuration
│   └── .gitconfig
├── shell/            # Shell configurations
│   ├── .bashrc
│   ├── .bash_profile
│   ├── .zshrc
│   └── .p10k.zsh
├── ssh/              # SSH configuration
│   └── .ssh/
│       └── config
├── install.sh        # Automated installation script
├── .gitignore        # Exclude sensitive files
└── README.md
```

## ⚡ Quick Installation

### Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/Hubertinhuilu/dotfiles.git ~/dotfiles

# Run the installation script
cd ~/dotfiles
./install.sh
```

The installation script will:
- ✅ Install Homebrew (if not present)
- ✅ Install GNU Stow for symlink management
- ✅ Install Oh My Zsh and Powerlevel10k theme
- ✅ Create symlinks to your home directory
- ✅ Set appropriate file permissions
- ✅ Optionally install common development tools

### Manual Installation

If you prefer manual control:

```bash
# Install dependencies
brew install stow

# Clone the repository
git clone https://github.com/Hubertinhuilu/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Stow individual packages
stow shell    # Links shell configs
stow git      # Links git config
stow ssh      # Links SSH config
stow config   # Links .config directory items

# Or stow everything at once
stow */
```

## 🔧 What's Included

### Shell Configuration
- **Zsh**: Complete Zsh configuration with Oh My Zsh
- **Powerlevel10k**: Beautiful and fast theme
- **Bash**: Fallback bash configuration
- **Aliases**: Custom aliases and functions

### Git Configuration
- User settings and preferences
- Global gitignore rules
- Custom Git aliases

### SSH Configuration
- Host-specific connection settings
- SSH key management setup

### Development Tools
- HTTop configuration
- Various development utilities

## 🚀 Usage

### Adding New Dotfiles

1. Create the file in the appropriate package directory:
   ```bash
   # Example: Add a new vim config
   mkdir -p ~/dotfiles/vim
   cp ~/.vimrc ~/dotfiles/vim/
   ```

2. Stow the package:
   ```bash
   cd ~/dotfiles
   stow vim
   ```

3. Commit and push:
   ```bash
   git add .
   git commit -m "Add vim configuration"
   git push
   ```

### Updating Configurations

When you modify a config file that's already stowed, the changes are automatically reflected in the repository since the files are symlinked.

### Managing Packages

```bash
# Install/activate a package
stow package_name

# Remove/deactivate a package  
stow -D package_name

# Re-stow (useful after changes)
stow -R package_name
```

## 🛠️ Customization

### Shell Theme
The Zsh configuration uses Powerlevel10k theme. To customize:

```bash
p10k configure
```

### Git Configuration
Update personal information in `git/.gitconfig`:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 📋 Prerequisites

- **macOS** (tested on macOS Sequoia)
- **Homebrew** (installed automatically by script)
- **Git** (usually pre-installed on macOS)
- **GitHub CLI** (for repository management, optional)

## 🔒 Security

- Sensitive files are excluded via `.gitignore`
- SSH keys and credentials are never committed
- Personal information should be reviewed before committing

## 🗂️ Backup

Before installation, existing dotfiles are automatically backed up with a `.backup` extension. You can restore them if needed:

```bash
# Restore original file
mv ~/.zshrc.backup ~/.zshrc
```

## 🐛 Troubleshooting

### Symlink Conflicts
If you encounter conflicts during stowing:

```bash
# Remove the conflicting file and re-stow
rm ~/.zshrc
stow shell
```

### Permission Issues
Ensure proper permissions for SSH:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
```

## 📚 Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Atlassian Dotfiles Tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

## 📄 License

This repository is for personal use. Feel free to fork and adapt for your own needs.

---

*Generated with ❤️ and organized with [GNU Stow](https://www.gnu.org/software/stow/)*