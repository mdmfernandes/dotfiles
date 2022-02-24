# ====================
# Miguel's ZSH aliases
# ====================

# Helper: check if a command exists
exists()
{
    command -v "$1" >/dev/null 2>&1
}

# ls
if [[ "$OSTYPE" != "darwin"* ]]; then   # If not in MacOS
    alias ls='ls --color=auto' # Colorize the output if a terminal is available
fi
alias la='ls -lAh'
alias ll='ls -lh'
alias l='ls -lh'
alias lt='ls -lthr'
alias ltr='ls -lth'
alias lsz='ls -lhSr'
alias lszr='ls -lhS'
alias l.='ls -d .*'

# cd
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias dv='dirs -v'

# grep
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

# Make directory with parents
alias md='mkdir -pv'

# Get real path of a file or directory
alias rpath='realpath'

# Use colordiff for diff, if installed
if exists colordiff; then
    alias diff='colordiff'
fi

# Use bat as cat, if installed
# Ubuntu
if exists batcat; then
    alias cat='batcat -pp'
fi
# Manjaro && MacOS
if exists bat; then
    alias cat='bat -pp'
fi

# Show path with \n
alias path='printf ${PATH//:/\\n}'

# Vim
if exists nvim; then
    alias vim='nvim'
fi
alias vi='vim'
alias edit='vim'
# `sudo -e` is the same as `sudoedit` but also works in MacOS
alias svi='sudo -e' # Requires 'EDITOR=nvim'

# Show all ports
alias ports='ss -tulpan'

## Securtiy
# Confirmation before override
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ln='ln -i'
# Don't allow to operate recursively on '/' (don't work in MacOS)
if [[ "$OSTYPE" != "darwin"* ]]; then
    alias chown='chown --preserve-root'
    alias chmod='chmod --preserve-root'
    alias chgrp='chgrp --preserve-root'
fi

# fzf
alias -g Z='| fzf'

# apt
alias ai='sudo apt install'
alias auu='sudo apt update && sudo apt upgrade -y'

# Become root
alias root='sudo -i'

# Disks
alias df='df -h'
alias dud='du -d 1 -h' # Size of files at depth 1 in current location
alias duf='du -sh' # Size of files in current location
alias dusz='du -sh | sort -h' # disk usage ordered by size
alias du='du -h'
alias lsblkf='lsblk --fs' # Show info about filesystems in `lsblk`

# IP
if [[ "$OSTYPE" != "darwin"* ]]; then   # If not in MacOS
    alias ip='ip -color=auto' # Colorize the output if a terminal is available
fi

# Git
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -vv'
alias gba='git branch -a -vv'
alias gbd='git branch --delete'
alias gbdf='git branch --delete --force'
alias gbr='git branch --remote'
alias gbu='git branch --set-upstream-to'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --stat'
alias gfv='git fetch --verbose'
alias gfp='git fetch --verbose --prune'
alias gl='git log'
alias gls='git log --stat'
alias glg='git log --graph'
alias glga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gmf='git merge --ff-only'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias grv='git remote --verbose'
alias grb='git rebase'
alias gri='git rebase --interactive'
alias gst='git status'
alias gss='git status --short'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch --detach'
alias gtg='git tag'
alias gtgn='git tag -n'
alias gtgr='git ls-remote --tags'
alias guf='git pull --ff-only'
alias gur='git pull --rebase'

# Docker
alias d='docker'
alias di='docker images'
alias dia='docker images -a'
alias dp='docker ps'
alias dpa='docker ps -a'
alias drc='docker rm'   # Remove one or more containers
alias dri='docker rmi'  # Remove one or more images
alias dpc='docker container prune'  # Delete stopped containers
alias dpi='docker image prune'      # Delete dangling images
# Docker-Compose
alias dco='docker-compose'
alias dcp='docker-compose ps'
alias dcpa='docker-compose ps -a'
alias dci='docker-compose images'

# TMUX
# Attach a session (last or named)
ta() {
    # If it has no arguments
    if [ -z "$1" ]; then
            tmux attach-session
    else
            tmux attach-session -t $1
    fi
}
# Create a session (default or named)
ts() {
    # If it has no arguments
    if [ -z "$1" ]; then
            tmux new-session
    else
            tmux new-session -A -s $1
    fi
}
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'

# Other commands
alias h='history'
alias help='man'
alias j='jobs -l'
alias :q='exit'
alias copy='xclip -in -selection clipboard'
alias zshrc="${=EDITOR} $ZDOTDIR/.zshrc"
