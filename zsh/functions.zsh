# ======================
# Miguel's ZSH functions
# ======================

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
