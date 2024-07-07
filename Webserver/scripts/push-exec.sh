#!/bin/bash

# This script uses config.yaml to:
# -Build the container
# -Tag it
# -Push it to the specified repository
# -Uses ssh with an alias to a restricted user account
#  on a Synology NAS with sudo enabled for only
#  start_watchtower.sh script which triggers
#  watchtower container to start and update the
#  currently live container of this python webserver.
#  Synology container config incldued for import.

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/../config.yaml"

# Load configuration using simplified awk commands
REPO_URL=$(awk '/repo_url:/ {gsub(/["\r]/, ""); print $2}' "$CONFIG_FILE")
PORT=$(awk '/port:/ {gsub(/["\r]/, ""); print $2}' "$CONFIG_FILE")
CONTAINER_TAG=$(awk '/container_tag:/ {gsub(/["\r]/, ""); print $2}' "$CONFIG_FILE")

# Debug config errors.
#echo $REPO_URL
#echo $PORT
#echo $CONTAINER_TAG
#echo ${REPO_URL}:${PORT}/${CONTAINER_TAG}

cd "$SCRIPT_DIR/.."

docker build -t ${CONTAINER_TAG}:latest -f Dockerfile .
docker tag ${CONTAINER_TAG}:latest ${REPO_URL}:${PORT}/${CONTAINER_TAG}
docker push ${REPO_URL}:${PORT}/${CONTAINER_TAG}

ssh -t task_nas "sudo /volume1/docker/watchtower/start_watchtower.sh"
