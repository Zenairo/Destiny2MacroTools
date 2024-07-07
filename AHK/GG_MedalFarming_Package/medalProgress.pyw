import json
import requests
import re
import math
import yaml
import os

def find_ahk_directory(start_dir):
    current_dir = start_dir
    while True:
        if os.path.basename(current_dir) == 'AHK':
            return current_dir
        parent_dir = os.path.dirname(current_dir)
        if parent_dir == current_dir:
            return None
        current_dir = parent_dir

# Find the AHK directory
script_dir = os.path.dirname(os.path.abspath(__file__))
ahk_dir = find_ahk_directory(script_dir)
if ahk_dir is None:
    raise FileNotFoundError("AHK directory not found in the directory hierarchy")

# Load configuration from AHK/config.yaml
config_file_path = os.path.join(ahk_dir, 'config.yaml')
with open(config_file_path, 'r') as config_file:
    config = yaml.safe_load(config_file)
    refreshCode = config['refreshCode']
    bungieID = config['bungieID']

def main():
    code()
    
def code():
    #refreshes the token used for inventory GET request
    url = "https://www.bungie.net/Platform/App/OAuth/token/"

    payload = f'grant_type=refresh_token&refresh_token={refreshCode}'
    headers = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Basic NDI0MzI6Q08tWGNaOVhOSUltQXdjSy5wa0VyQ1hWekF2SFNocmluMGYuOGVjWWlKTQ==',
    }

    response = requests.request("POST", url, headers=headers, data=payload)
    data = response.text

    class Payload(object):
        def __init__(self, data):
            self.__dict__ = json.loads(data)

    p = Payload(data)

    a = p.access_token


    # X-SelfUrl: https://www.bungie.net/Platform/Destiny2/3/Profile/4611686018471192740/?components=100,102,103,104,200,,202,204,205,300,,302,303,304,305,306,307,308,309,310,700,800,900,1000,1100,1200,1400

    #make request for character inventories and their objectives
    url = f"https://www.bungie.net/Platform/Destiny2/3/Profile/{bungieID}/?components=201,301"
    
    payload = {}
    headers = {
  'x-api-key': '04b7f960a9d3495fbf647fa515ef5a88',
  'Authorization': f'Bearer {a}',
    }

    inventoryResponse = requests.request("GET", url, headers=headers, data=payload)
    inventory = inventoryResponse.text

    instancePattern = re.compile('\"itemHash\":2133003436,\"itemInstanceId\":\"([0-9]*)\"')
    
    if checkInventory(inventory):
    
        instanceId = instancePattern.search(inventory).group(1)

        print("InstanceID: " + instanceId)
        
        objectiveValuePattern = re.compile('\"' + instanceId + '\":{\"objectives\":\\[{\"objectiveHash\":1790670193,\"progress\":([0-9]*),')

        objectiveValue = objectiveValuePattern.search(inventory).group(1)

        print("Progress: " + objectiveValue + "/300")

        percent = int(objectiveValue) / 300

        progress = math.floor(percent * 100)

        exit(progress)

    else:
        exit(-1)


def checkInventory(inventory):
    if '2133003436' in inventory:
        #this if statement checks for if the bounty is in your inventory
        print("Bounty found")
        return True
    else:
        print("Bounty not found")
        return False


if __name__ == "__main__":
    main()