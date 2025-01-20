#!/bin/sh
set -e

log() {
    MSG="$1"
    TIMESTAMP=$(date '+%b %d %H:%M:%S')
    echo "=== $TIMESTAMP - $MSG ==="
}

log "Starting host configuration"

brew update

brew install stats rectangle domzilla-caffeine itsycal licecap
