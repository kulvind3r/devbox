#!/bin/bash
set -e

ARG="$1"
WORK_DIR=$(pwd)

run() {
  find "$WORK_DIR/" -maxdepth 1 -type d | while read DIR
  do
    cd "${DIR}"
    [[ -d .git ]] && printf "\n\n==== %s ====\n\n" $(basename "${DIR}") && git $ARG
  done
  
  #Return to work directory
  cd "$WORK_DIR"
}

run
