#!/bin/bash

CONFIG_FILE=config.yaml

awk '/user:/ { user=$2 } /host:/ { host=$2; gsub(/["\r]/, "", user); gsub(/["\r]/, "", host); print user, host }' $CONFIG_FILE | while IFS=" " read -r user host; do
    if ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no -i ~/.ssh/id_python_container ${user}@${host} 'exit'; then
        scp -r -o StrictHostKeyChecking=no -i ~/.ssh/id_python_container ../AHK ${user}@${host}:/AHK/ || echo "Failed to copy AHK folder to ${user}@${host}"
    else
        echo "Host ${host} is not reachable"
    fi
done