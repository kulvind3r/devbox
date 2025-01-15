#!/bin/sh
set -e

ROLE=$1
VM_NAME=devbox

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

run_in_vm() {
    limactl shell $VM_NAME $@
}

log "Validate $VM_NAME is setup and running"
if limactl list | grep $VM_NAME | grep -iq running;
then
    log "$VM_NAME exists and is running. Continuing with configuration."
else
    log "$VM_NAME is either not provisioned or is stopped. Please makesure 'provision-devbox' succeeds before proceeding"
    exit 1
fi

log "Detect user created by lima";
VM_USER=$(limactl shell $VM_NAME whoami)

log "Detect lima vm arch";
VM_ARCH=$(limactl shell $VM_NAME uname -m)

log "Run ansible code"
run_in_vm ansible-playbook ./ansible/$ROLE.yml --extra-vars "current_user=$VM_USER" --extra-vars "vm_arch=$VM_ARCH"

log "Check restart requirement"
if run_in_vm microk8s version; then
    log "group changes already applied. skipping restart"
else
    log "Restart VM to reload group configuration changes"
    limactl stop $VM_NAME
    limactl start $VM_NAME
fi

# uses limactl shell instead of run_in_vm function to force ~ evaluation inside vm
log "Add microk8s context in kubectl config"
if limactl shell $VM_NAME bash -c 'grep -q microk8s-cluster ~/.kube/config'; then 
    log "microk8s context already added to .kube/config"
else
    limactl shell $VM_NAME bash -c 'microk8s config >> ~/.kube/config'; 
fi
