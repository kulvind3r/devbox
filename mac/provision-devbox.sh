#!/bin/sh
set -eu

VM_NAME=devbox

log() {
    MSG="$1"
    TIMESTAMP=$(date '+%b %d %H:%M:%S')
    echo "=== $TIMESTAMP - $MSG ==="
}

run_in_vm() {
    limactl shell $VM_NAME $@
}

log "Validate lima is installed"
if ! limactl -v > /dev/null; then
    log "Lima is not installed correctly. Please makesure 'limactl -v' succeeds before proceeding"
    exit 1
fi

TOTAL_CORES=$(sysctl -n hw.ncpu)
TOTAL_MEMORY=$(expr $(sysctl -n hw.memsize) / $((1024**3)))

VM_CORES=$(expr $TOTAL_CORES / 2)
VM_MEMORY=$(expr $TOTAL_MEMORY / 2)

if limactl list | grep devbox > /dev/null;
then
    log "$VM_NAME already exists. Skipping provisioning."
else
    log "Provision ubuntu-lts vm on lima with $VM_CORES cores and $VM_MEMORY GB memory. $HOME Dir mounted writable."
    limactl start --tty=false --name=$VM_NAME --cpus=$VM_CORES --memory=$VM_MEMORY --mount-writable --mount-type=virtiofs template://ubuntu-lts
fi

log "Enable ssh to lima vm"
if grep $VM_NAME ~/.ssh/config > /dev/null; 
then 
    log "SSH already enabled";
else
    echo "" >> ~/.ssh/config;
    echo "Include ${LIMA_HOME:-$HOME/.lima}/$VM_NAME/ssh.config" >> ~/.ssh/config;
fi

log "Detect user created by lima";
VM_USER=$(limactl shell devbox whoami)

log "Add symlink to OSX Home directory in Guest OS"
run_in_vm ln -sf /Users/$USER /home/$VM_USER.linux/osx

log "Copy existing ssh keys and known host details to vm"
run_in_vm cp -r /Users/$USER/.ssh/* /home/$VM_USER.linux/.ssh/

log "Install ansible"
if run_in_vm which ansible > /dev/null; 
then 
    log "ansible is already installed";
else
    run_in_vm sudo apt -y update
    run_in_vm sudo apt -y install software-properties-common
    run_in_vm sudo add-apt-repository --yes --update ppa:ansible/ansible
    run_in_vm sudo apt -y install ansible
fi