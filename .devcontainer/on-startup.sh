#!/bin/bash
set -eux

LOG=/tmp/on-startup.log

git config --global credential.helper 'cache --timeout=36000'

# Start SSH agent if not running
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

PROJ_DIR="/workspaces/rdc-utils/rdc_utils"

if [ ! -d "$PROJ_DIR" ]; then
    echo "First-time setup: cloning repo..." | tee -a $LOG

    # Example: private GitLab repo
    git clone ssh://git@gitlab-master.nvidia.com:12051/autonomous_data_center/rdc_utils.git  "$PROJ_DIR" |& tee -a $LOG

else
    echo "$PROJ_DIR already initialized, skipping clone." | tee -a $LOG
fi

