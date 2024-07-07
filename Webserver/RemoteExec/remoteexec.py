#!/usr/bin/env python3
import click
from flask import Flask
import logging
import subprocess
import yaml

app = Flask(__name__)
logger = logging.getLogger('RemoteExec')

# Load configuration
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

ssh = f'ssh -o StrictHostKeyChecking=no -i /root/.ssh/id_python_container'
servers = {server["id"]: server for server in config["servers"]}
scripts = config["scripts"]
psexec = config["psexec"]
autohotkey = config["autohotkey"]

@app.route('/<string:botNumber>/<string:scriptName>', methods=['GET'])
@app.route('/<string:botNumber>/<string:scriptName>/<string:userName>/<string:userNumber>', methods=['GET'])
def callAhk(botNumber, scriptName, userName=None, userNumber=None):
    logger.debug('callAhk called with arguments: botNumber=%s, scriptName=%s, userName=%s, userNumber=%s', botNumber, scriptName, userName, userNumber)
    if scriptName in scripts:
        server = servers[botNumber]
        user = server["user"]
        host = server["host"]
        command = f"{ssh} {user}@{host} '{psexec} {autohotkey} {scripts[scriptName]}'"
        if userName and userNumber:
            command += f" {userName}#{userNumber}"
        logger.debug('SSH: %s', command)
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
        logger.info('Called script %s', scriptName)
        return "<p>Script found, called: " + scriptName + " </p>"
    else:
        logger.info('Invalid request for %s', scriptName)
        return "<p>Script not found!</p>"

@click.command()
def RemoteExec():
    logging.basicConfig(format='%(asctime)s %(levelname)-8s %(message)s')
    logger.setLevel('DEBUG')
    logger.info('Starting remote exec listen server')

    app.run(host='0.0.0.0', port=5400, debug=True)

if __name__ == '__main__':
    RemoteExec()
