# Aliases

# Check if a command exists
exists()
{
    command -v "$1" >/dev/null 2>&1
}

# ls
alias l.='ls -d .*'
alias lt='ls -lth'

# Make directory with parents
alias mkdirp='mkdir -pv'

# Use colordiff for diff, if installed
if exists colordiff; then
    alias diff='colordiff'
fi

# Use bat as cat, if installed
if exists batcat; then
    alias cat='batcat -pp'
fi

# Show path with \n
alias path='printf ${PATH//:/\\n}'

# Vim
alias vim='nvim'
alias vi='nvim'
alias svi='sudo nvim'
alias edit='nvim'

# Show all ports
alias ports='ss -tulpan'

## Securtiy
# Confirmation before override
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ln='ln -i'
# Don't allow to operate recursively on '/'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# apt
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
if [[ "$OSTYPE" != "darwin"* ]]; then   # If not in MacOS
    alias ip='ip -color=auto' # Colorize the output if a terminal is available
fi

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

# Gron
alias norg="gron --ungron"

# Other commands
alias h='history'
alias help='man'
alias j='jobs -l'
alias :q='exit'
alias copy='xclip -in -selection clipboard'
alias zshrc='${=EDITOR} ~/.config/zsh/.zshrc'

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
    if exists jq; then
        curl -s -u $IPINFO_TOKEN: https://ipinfo.io/$1 | jq
    else
        curl -s -u $IPINFO_TOKEN: https://ipinfo.io/$1
    fi
}

# Get domain info
domaininfo() {
    # If it's empty
    if [ -z "$1" ]; then
        echo "You need to provide a domain. Usage: domaininfo <domain>"
        return 1
    fi
    # Check if the domain has a valid format
    result=$(echo $1 | grep -E '^@[a-zA-Z0-9]+([-.]?[a-zA-Z0-9]+)*.[a-zA-Z]+$')
    if [[ -z result ]]; then
        echo "Invalid domain format"
        return 2
    fi

    # If jq is installed, make the output prettier
    if exists jq; then
        curl -s -u $HOSTIO_TOKEN: https://host.io/api/full/$1 | jq
    else
        curl -s -u $HOSTIO_TOKEN: https://host.io/api/full/$1
    fi
}
