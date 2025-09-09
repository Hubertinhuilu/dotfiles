export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
if [ -d "$HOME/.local/bin" ] ; then
export PATH="$HOME/.local/bin:$PATH"
fi
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home"
PATH="${JAVA_HOME}/bin:${PATH}"
export PATH

# export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/tuukkaalavaikko/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/tuukkaalavaikko/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/tuukkaalavaikko/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/tuukkaalavaikko/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/tuukkaalavaikko/.lmstudio/bin"
