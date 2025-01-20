#!/bin/sh
set -e

log() {
    MSG="$1"
    TIMESTAMP=$(date '+%b %d %H:%M:%S')
    echo "=== $TIMESTAMP - $MSG ==="
}

log "Starting host configuration"

log "Updating brew"
brew update

log "Installing apps if absent"

ls /Applications/Stats.app > /dev/null || brew install stats
ls /Applications/Rectangle.app > /dev/null || brew install rectangle
ls /Applications/Caffeine.app > /dev/null || brew install domzilla-caffeine
ls /Applications/Itsycal.app > /dev/null || brew install itsycal 
ls /Applications/LICEcap.app > /dev/null || brew install licecap

log "Finished installing apps"
