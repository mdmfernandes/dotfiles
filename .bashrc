# History control
# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth
# Append to the history file, don't overwite it
shopt -s histappend
# History size
HISTSIZE=100000
HISTFILESIZE=200000

# Enable programmable completion features 
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
    fi
fi

# Aliases are in .bash_aliases to keep things clean
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default editor is VIM
export EDITOR=/usr/bin/vim

