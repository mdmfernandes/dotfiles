#########################
# Custom configurations #
#########################
# Examples:
#### SSH using GPG keys #######################################################
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

#### gf #######################################################################
[[ -r "$GOPATH/src/github.com/tomnomnom/gf/gf-completion.zsh" ]] && source "$GOPATH/src/github.com/tomnomnom/gf/gf-completion.zsh"
