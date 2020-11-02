#####################
# Mike's ZSH config #
#####################

# Preferred editor for local and remote sessions
# this is required for TMUX and needs to be before loading the plugin
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
    export VISUAL='nvim'
else
    export EDITOR='nvim'
    export VISUAL='nvim'
fi

# Set language environment
export LANG=en_US.UTF-8


# Oh-my-zsh configuration
# Path to oh-my-zsh installation
export ZSH="$HOME/.config/zsh/.oh-my-zsh"

# oh-my-zsh theme to use
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.config/zsh/.p10k.zsh

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Plugins settings
_Z_DATA=$HOME/.config/zsh/.z
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false

# Plugins to load
# - Standard plugins can be found in ~/.oh-my-zsh/plugins/*
#  -Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode tmux colored-man-pages z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#####################
# ZSH configuration #
####################
#setopt interactivecomments  # allow comments in interactive mode
setopt noclobber             # prevent from overwriting an existing file
#setopt magicequalsubst      # enable filename expansion for arguments of the form 'anything=expression'
#setopt nonomatch            # hide error message if there is no match for the pattern
#setopt notify               # report the status of background jobs immediatly
#setopt numericglobsort      # sort filenames numerically when it makes sense
#setopt promptsubst          # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# Change EOL sign (default: '%')
PROMPT_EOL_MARK='%S$%s'


# History file
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_ignore_space        # ignore commands that start with space
setopt hist_verify              # show command with history expansion to user before running it

# force zsh to show the complete history
alias history="history 0"

# don't complete functions
zstyle ':completion:*:functions' ignored-patterns '_*'

#new_line_before_prompt=yes
#precmd() {
    ## Print the previously configured title
    #print -Pnr -- "$TERM_TITLE"

    ## Print a new line before the prompt, but only if it is not the first line
    #if [ "$new_line_before_prompt" = yes ]; then
        #if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            #_NEW_LINE_BEFORE_PROMPT=1
        #else
            #print ""
        #fi
    #fi
#}


######################
# User configuration #
######################
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

# gf autocomplete
[[ -r "$GOPATH/src/github.com/tomnomnom/gf/gf-completion.zsh" ]] && source "$GOPATH/src/github.com/tomnomnom/gf/gf-completion.zsh"
