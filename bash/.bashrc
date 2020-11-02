# History control
# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth
# Append to the history file, don't overwite it
shopt -s histappend
# History size
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="&:ls:[bf]g:exit:history"

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\W\[\033[92m\] ➜ \[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\w\$ '
fi  

# Default editor is VIM
export EDITOR=vim

# Use vim mode in bash
set -o vi
bind -m vi-insert "\C-l":clear-screen # Map C-l to clear screen in edit mode

# Enable SSH using GPG keys
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# GRC - Generic colourizer
[[ -s "/etc/grc.bashrc" ]] && source /etc/grc.bashrc
