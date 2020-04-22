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

# Git
alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbv='git branch -vv'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'

alias gff='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias gfg='git ls-files | grep'

alias gg='git gui citool'
alias gga='git gui citool --amend'

alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'

alias gignored='git ls-files -v | grep "^[[:lower:]]"'

alias gl='git log'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'
alias gma='git merge --abort'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'

alias gsw='git switch'
alias gswc='git switch -c'

alias gts='git tag -s'
alias gtv='git tag | sort -V'

alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias glum='git pull upstream master'

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
alias ...='cd ../..'
alias ....='cd ../../..'
alias ....='cd ../../../..'
alias ......='cd ../../../../..'
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
        curl -s ipinfo.io/$1 | jq
    else
        curl -s ipinfo.io/$1
    fi
}

