###################################################
# This is a template for the ZSH config (.zshrc). #
# Adapt your .zshrc file according to your needs. #
###################################################

## ZSH configuration

# Path to oh-my-zsh installation
export ZSH="$HOME/.config/zsh/.oh-my-zsh"

# oh-my-zsh theme to use
ZSH_THEME="mike"

# Command auto-correction
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# History file
HISTFILE=$HOME/.config/zsh/.zsh_history
HIST_STAMPS="yyyy-mm-dd"
HISTORY_IGNORE='([bf]g *|l[alsh]#( *)#|less *|vim# *|pwd|history|h|cd ..|..|...|....|.....)' 

# Plugins settings
_Z_DATA=$HOME/.config/zsh/.z
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false

# Plugins to load
# - Standard plugins can be found in ~/.oh-my-zsh/plugins/*
#  -Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt vi-mode tmux docker golang gcloud colored-man-pages z)

source $ZSH/oh-my-zsh.sh


## User configuration
# Set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Enable SSH using GPG keys
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent


## Applications configuration
# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Google Cloud SDK
CLOUDSDK_HOME=$HOME/Apps/google-cloud-sdk 

# CUDA
export PATH=$PATH:/usr/local/cuda-10.2/bin
export PATH=$PATH:/usr/local/cuda-10.2/targets/x86_64-linux/include
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64:/usr/local/cuda-10.2/targets/x86_64-linux/lib

# gf autocomplete
[[ -r "$GOPATH/src/github.com/tomnomnom/gf/gf-completion.zsh" ]] && source "$GOPATH/src/github.com/tomnomnom/gf/gf-completion.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
