#!/bin/bash

# This script is useful for stopping, removing,
# building, then running the container locally.

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="remote-exec:latest"
CONTAINER_NAME="remote-exec"
DOCKERFILE="$SCRIPT_DIR/../Dockerfile"
HOST_PORT=5400
CONTAINER_PORT=5400

# Change to the project root directory
cd "$SCRIPT_DIR/.."

# Stop and remove the existing container
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Build the new Docker image
docker build -t $IMAGE_NAME -f $DOCKERFILE .

# Run the container
docker run --name $CONTAINER_NAME --net=host -d -p $HOST_PORT:$CONTAINER_PORT $IMAGE_NAME

# Uncomment the line below to execute the Python script inside the running container
# docker exec -it $CONTAINER_NAME bash -c "./remoteexec.py"

# Uncomment the line below to enter the running container
# docker exec -it $CONTAINER_NAME bash
