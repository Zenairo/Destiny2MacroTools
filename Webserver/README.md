# Webserver

This project is a Flask-based web server that executes AutoHotkey (AHK) scripts on remote Windows machines via SSH. It leverages `PsExec` and `AutoHotkey` to run scripts on specified remote hosts.

## Folder Structure

- **/keys**: Contains the SSH keys used for authentication.
  - `id_python_container`: Private SSH key.
  - `id_python_container.pub`: Public SSH key.
- **/RemoteExec**: Contains the main Python script for executing remote commands.
  - `remoteexec.py`: Main Python script that starts the Flask server and handles the execution of remote AHK scripts.
- **/scripts**: Contains shell scripts for building and running the Docker container.
  - `push-exec.sh`: Script to build and push the Docker image.
  - `remote_exec_start.sh`: Script to stop, remove, build, and run the Docker container locally.
- **.gitlab-ci.yml**: GitLab CI/CD configuration file for automating the build and deployment process.
- **Dockerfile**: Dockerfile for building the Docker image.
- **README.md**: This README file.

## Setup and Usage

### Prerequisites

- Docker
- GitLab Runner (if using GitLab CI/CD)

### Configuration

Create a `config.yaml` file in the root of the Webserver folder with the following structure:

- **ssh**: Configuration for SSH, including the path to the SSH key.
- **servers**: List of servers with unique IDs, user names, and host addresses.
- **scripts**: Key-value pairs where the key is the API endpoint and the value is the path to the corresponding AHK script.
- **psexec**: Path to the `PsExec` executable.
- **autohotkey**: Path to the `AutoHotkey` executable.

### Example `config.yaml`

```yaml
ssh:
  key_path: /root/.ssh/id_python_container

servers:
  - id: "1"
    user: MachineName1
    host: IP1
  - id: "2"
    user: MachineName2
    host: IP2

scripts:
  gotoexp: "C:\\AHK\\gotoexp.ahk"
  startexp: "C:\\AHK\\startexp.ahk"
  stopexp: "C:\\AHK\\stopexp.ahk"
  # Add other script mappings here...

psexec: '"C:\\Portable Programs\\PSTools\\PsExec.exe" -s -d -i 1'
autohotkey: '"C:\\Program Files\\AutoHotkey\\AutoHotkey.exe"'
