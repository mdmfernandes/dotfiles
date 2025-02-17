# ======================
# Miguel's ZSH functions
# ======================

# Get IP info
function ipinfo() {
    # If it's empty
    if [ -z "$1" ]; then
        ip=""
    # If it's a valid IP
    elif [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        ip=$1
    else
        echo -e '\e[31mInvalid IP address (IPv4 only)\e[0m'
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
function domaininfo() {
    # If it's empty
    if [ -z "$1" ]; then
        echo "You need to provide a domain. Usage: domaininfo <domain>"
        return 1
    fi
    # Check if the domain has a valid format
    result=$(echo $1 | grep -E '^@[a-zA-Z0-9]+([-.]?[a-zA-Z0-9]+)*.[a-zA-Z]+$')
    if [[ -z result ]]; then
        echo -e '\e[31mInvalid domain format\e[0m'
        return 2
    fi

    # If jq is installed, make the output prettier
    if exists jq; then
        curl -s -u $HOSTIO_TOKEN: https://host.io/api/full/$1 | jq
    else
        curl -s -u $HOSTIO_TOKEN: https://host.io/api/full/$1
    fi
}

# Calculator
function calc() {
    bc -l <<< ${*//[xX]/*}
}

# Decode JWTs
function jwtd() {
    # This function only works if jq is installed
    if exists jq; then
        jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< $1
        echo "Signature: $(echo "${1}" | awk -F'.' '{print $3}')"
    else
        echo -e '\e[31m`jq` is not installed and is required\e[0m'
    fi
}

# yazi shell wrapper: https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
