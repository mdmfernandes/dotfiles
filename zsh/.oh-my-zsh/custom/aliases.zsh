# Aliases

# ls
alias l.='ls -d .*'
alias lt='ls -lth'

# Use colordiff for dif, if installed
if [ -n "$(which colordiff)" ]; then
    alias diff='colordiff'
fi

# Show path with \n
alias path='printf ${PATH//:/\\n}'

# Vim
alias vi='vim'
alias svi='sudo vim'
alias edit='vim'

# Show all ports
alias ports='ss -tulpan'

## Securtiy
# Confirmation before override
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ln='ln -i'
# Don't allow to operate recursively on '/'
#alias chown='chown --preserve-root'
#alias chmod='chmod --preserve-root'
#alias chgrp='chgrp --preserve-root'

# apt
alias ai='sudo apt install'
alias auu='sudo apt update && sudo apt upgrade -y'

# Become root
alias root='sudo -i'

# git (override the zsh plugin)
alias gl='git log'
alias gs='git status'
alias gbv='git branch -vv'
alias gff='git fetch'
unalias gf

# docker
alias d='docker'
alias di='docker images'
alias dia='docker images -a'
alias dp='docker ps'
alias dpa='docker ps -a'
alias drc='docker rm'   # Remove one or more containers
alias dri='docker rmi'  # Remove one or more images
alias dpc='docker container prune'  # Delete stopped containers 
alias dpi='docker image prune'      # Delete dangling images
# docker-compose
alias dcp='docker-compose ps'
alias dcpa='docker-compose ps -a'
alias dci='docker-compose images'

# tmux (override the zsh plugin)
alias tk='tmux kill-session -t'

# Disk usage
alias df='df -h'
alias du='du -h'
alias dud='du -d 1 -h' # Size of files at depth 1 in current location
alias duf='du -sh' # Size of files in current location

# Other commands
alias h='history'
alias help='man'
alias j='jobs -l'
alias :q='exit'
alias zshrc='${=EDITOR} ~/.config/zsh/.zshrc'

# Gron
alias norg="gron --ungron"

# IP
alias ip='ip -color=auto' # Colorize the output if a terminal is available

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
    
    # If jq is installed
    if [ -n "$(which jq)" ]; then
        curl -s ipinfo.io/$1 | jq
    else
        curl -s ipinfo.io/$1
    fi
}
