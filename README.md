# Destiny 2 Macro Tools

This repository contains tools and scripts for automating tasks in Destiny 2 using AutoHotkey (AHK) and a Flask-based web server to execute these scripts remotely on Windows machines.

## Repository Structure

- **/AHK**: Contains all the AutoHotkey scripts and Python code necessary for interacting with the Destiny 2 API.
  - **scripts**: Various AHK scripts for automating tasks within Destiny 2.
  - **Python**: Python code that interfaces with the Destiny 2 API to provide data-driven automation available to AHK.

- **/Webserver**: Contains a Flask-based web server for executing remote AHK scripts.
  - **keys**: SSH keys for authentication.
  - **RemoteExec**: The main Python script for the Flask server.
  - **scripts**: Shell scripts for building and running Docker containers.
  - **.gitlab-ci.yml**: Configuration for GitLab CI/CD.
  - **Dockerfile**: Instructions to build the Docker image for the web server.

## Setup and Usage

### Prerequisites

- AutoHotkey installed on the target Windows machines
- Docker
- GitLab Runner (if using GitLab CI/CD)
- PSExec installed on target Windows machines

### Configuration and Running

1. **Configure**:
   - Create a `config.yaml` in the Webserver folder with necessary SSH, server, and script paths.

2. **Build and Run**:
   - Use the provided shell scripts to build and run the Docker container locally or via CI/CD.

### License

This project is licensed under the MIT License. See the LICENSE file for details.
