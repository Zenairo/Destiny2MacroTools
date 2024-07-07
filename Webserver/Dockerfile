# Use a small base image
FROM python:3.9-slim

# Add Watchtower label for auto-update
LABEL com.centurylinklabs.watchtower.enable="true"

# Set environment variables
ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y openssh-client

# Install Python packages
RUN pip3 install click flask pyyaml

# Create the .ssh directory and add the key
RUN mkdir -p /root/.ssh
ADD ./keys/id_python_container /root/.ssh/id_python_container
RUN chmod 600 /root/.ssh/id_python_container

# Copy application code and config
COPY RemoteExec /RemoteExec
COPY config.yaml /RemoteExec/config.yaml
WORKDIR /RemoteExec
RUN chmod +x remoteexec.py

ENTRYPOINT ["python", "./remoteexec.py"]

# Expose the port the application runs on
EXPOSE 5400
