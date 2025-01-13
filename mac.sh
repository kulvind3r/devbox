#!/bin/sh
set -e

ROLE=$1

if [ -z $ROLE ]; then
    printf "\nPlease provide atleast one role from below as parameter.\n\n"
    find ansible/ -maxdepth 1 -type f -exec basename {} .yml \;
    printf "\n";
    exit 1
fi

log() {
    MSG="$1"
    TIMESTAMP=$(date '+%b %d %H:%M:%S')
    echo "=== $TIMESTAMP - $MSG ==="
}

log "Bootstrapping Mac - cmd-tools, brew, lima"
./mac/bootstrap.sh

log "Provisioning ubuntu 24.04 LTS vm on lima with ansible"
./mac/provision-devbox.sh

log "configuring devbox on lima with role $ROLE"
./mac/configure-devbox.sh $ROLE

log "Devbox provisioning complete. To login run, 'ssh lima-devbox'"

log "Optional host configuration"
GREEN='\033[0;32m'
NO_COLOR='\033[0m'
echo "${GREEN}"
echo "Would you also like to configure applications for your Host i.e. macOS?"
echo "This would install a bunch of quality of life applications on your macbook like stats, itsycal, rectangle etc."
read -p "Conitnue Y/N : " USER_CHOICE
echo "${NO_COLOR}"

if echo $USER_CHOICE | grep -iqE "y|yes"; then
    ./mac/configure-host.sh
else
    log "Host configuration rejected"
fi

log "Finished"
