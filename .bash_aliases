## Custom aliases
# ls
alias ll='ls -AlhF'
alias la='ls -A'
alias l='ls -F'
alias l.='ls -d .*' # Show hidden files
alias lt='ls -lth'  # Show recent first (modification time)

# grep (add color to output)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Make directory with parents
alias mkdirp='mkdir -pv'

# Diff with colors (requires colordiff)
alias diff='colordiff'

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
alias du='du -ch'
alias biggest='du -c --max-depth=1 | sort -h'

# Git
alias ga='git add'
alias gA='git add --all :/' # Stage all
alias gam='git add -u'      # Stage modified/deleted (i.e. not untracked)
alias gan='git add .'       # Stage new
alias gc='git commit -m'
alias gca='git commit -am'
alias gd='git diff'
alias gfm='git fetch origin && git merge origin/master'
alias gfrb='git fetch origin && git rebase origin/master'
alias glc='git ls-files | xargs wc -l'
alias gm='git merge'
alias gmom='git merge origin/master'
alias gp='git push'
alias gpo='git push origin'
alias gs='git status'

# Docker
alias d="docker"
alias di="docker images"
alias dia="docker images -a"
alias dp="docker ps"
alias dpa="docker ps -a"
alias drc="docker rm"   # Remove one or more containers
alias dri="docker rmi"  # Remove one or more images
alias drxc="docker ps -a -f status=exited -q | xargs docker rm"   # Remove all exited containers
alias drxi="docker images -f dangling=true -q | xargs docker rmi" # Remove all dangling images
alias dc="docker-compose"
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
alias tls="tl"
alias tk="tmux kill-session -t"     # Kill a named session
# Create a session (default or named)
tn() {
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
alias j='jobs -l'
alias :q="exit"

# Use grc (requires grc)
# More aliases here: https://github.com/garabik/grc/blob/master/grc.bashrc
if [ -n "$(which grc)" ]; then                                                                      
    alias env='grc env'
    alias id='grc id'   
    alias lsof='grc lsof'                         
    alias ping='grc ping' 
    alias dig='grc dig'                           
    alias ps='grc ps'
    alias ip='grc ip'
    alias ifconfig='grc ifconfig'
    alias nmap='grc nmap' 
fi

# Change up directories
# Avoid error 'command not found'
alias cd..='cd ..'
# Change up a variable number of directories
# E.g:
#   ..   -> cd ../
#   .. 2 -> cd ../../
#   .. 3 -> cd ../../../
..() {
    local count=$1
    if [ -z "${count}" ]; then
        count=1
    fi
    local path=""
    for i in $(seq 1 ${count}); do
        path="${path}../"
    done
    cd $path
}

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
        curl -s  ipinfo.io/$1 | jq
    else
        curl -s  ipinfo.io/$1
    fi
}

