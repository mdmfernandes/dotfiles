## Custom aliases
# ls
alias ls='ls --color=auto'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='ls -lah'
alias l.='ls -d .*' # Show hidden files
alias lt='ls -lth'  # Show recent first (modification time)

# grep (add color to output)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Make directory with parents
alias mkdirp='mkdir -pv'

# Use colordiff for diff, if installed
if [ -n "$(which colordiff)" ]; then
    alias diff='colordiff'
fi

# Use bat as cat, if installed
if [ -n "$(which batcat)" ]; then
    alias cat='batcat -pp'
fi

# Show path with \n
alias path='printf ${PATH//:/\\n}'

# Vim
alias vi=vim
alias svi='sudo vim'
alias edit='vim'

# Show all ports
alias ports='ss -tulpan'

# Security
# Confirmation before overwite
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ln='ln -i'
# Don't allow to operate recursively on '/'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Apt
alias ai='sudo apt install'
alias auu='sudo apt update && sudo apt upgrade -y'

# Become root
alias root='sudo -i'

# Disks
alias df='df -h'
alias du='du -h'
alias dud='du -d 1 -h' # Size of files at depth 1 in current location
alias duf='du -sh' # Size of files in current location

# IP
alias ip='ip -color=auto' # Colorize the output if a terminal is available

# Git
alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch --remote'
alias gbv='git branch -vv'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gco='git checkout'

alias gl='git log'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'

alias gs='git status'
alias gss='git status -s'

alias gsw='git switch'
alias gswc='git switch -c'

# Docker
alias d="docker"
alias di="docker images"
alias dia="docker images -a"
alias dp="docker ps"
alias dpa="docker ps -a"
alias drc="docker rm"   # Remove one or more containers
alias dri="docker rmi"  # Remove one or more images
alias dpc="docker container prune"  # Delete stopped containers 
alias dpi="docker image prune"      # Delete dangling images
# Docker-Compose
alias dco="docker-compose"
alias dcp="docker-compose ps"
alias dcpa="docker-compose ps -a"
alias dci="docker-compose images"

# tmux
# Attach a session (last or named)
ta() {
	# If it has no arguments
	if [ -z "$1" ]; then
		tmux attach-session
	else
		tmux a -t $1
	fi
}
alias tl="tmux list-sessions"       # List sessions
alias tk="tmux kill-session -t"     # Kill a named session
# Create a session (default or named)
ts() {
	# If it has no arguments
	if [ -z "$1" ]; then
		tmux new-session
	else
		tmux new -s $1
	fi
}

# Gron
alias norg="gron --ungron"

# Other commands
alias h='history'
alias help='man'
alias j='jobs -l'
alias copy='xsel -i -b'
alias :q="exit"

# Change up directories
# Avoid error 'command not found'
alias cd..='cd ..'
# Change up a variable number of directories
alias ...='cd ../..'
alias ....='cd ../../..'
alias ....='cd ../../../..'
alias ......='cd ../../../../..'
#   ..   -> cd ../
#   .. 2 -> cd ../../
#   .. 3 -> cd ../../../

# Get IP info
ipinfo() {
    # If it's empty
    if [ -z "$1" ]; then
        ip=""
    # If it's a valid IP
    elif [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        ip=$1
    else
        echo "Invalid IP address (IPv4 only)"
        return
    fi

    # If jq is installed, make the output prettier
    if [ -n "$(which jq)" ]; then
        curl -s ipinfo.io/$1 | jq
    else
        curl -s ipinfo.io/$1
    fi
}
