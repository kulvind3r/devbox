#!/bin/sh
set -eu

log() {
    MSG="$1"
    TIMESTAMP=$(date '+%b %d %H:%M:%S')
    echo "=== $TIMESTAMP - $MSG ==="
}

install_cmd_tools() {
    log "Installing osx command line tools"
    xcode-select --install || :

    log "Validate command line tools are installed"
    if ! pkgutil --pkgs | grep -i tools; then
        log "Command line tools installation failed. Please make sure 'xcode-select --install' succeeds before proceeding"
        exit 1
    fi
}

install_homebrew() {
    log "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    log "Validate brew is installed"
    if ! brew --version > /dev/null; then
        log "Brew installation failed. Please make sure brew is installed before proceeding"
        exit 1;
    fi
}

if pkgutil --pkgs | grep -i tools > /dev/null; 
then
    log "Command line tools already installed."
else
    install_cmd_tools    
fi

if brew --version > /dev/null;
then
    log "Homebrew already installed"
else
    install_homebrew
fi

if limactl -v > /dev/null;
then
    log "lima already installed"
else
    log "Installing lima"
    brew install lima
fi