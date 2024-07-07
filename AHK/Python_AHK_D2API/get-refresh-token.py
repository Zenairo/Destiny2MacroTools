import json
import requests

#at some point in time I'll add something to get user ID along with the refresh token
bungieID = '???'

def main():
    code()
    
def code():
    #goes to application authorization page
    print("Go to https://www.bungie.net/en/oauth/authorize?client_id=42432&response_type=code for a code." )
    bungieID = input('Enter the stuff that comes after code=')
    
    #requests for refresh token
    url = "https://www.bungie.net/Platform/App/OAuth/Token/"

    payload=f'grant_type=authorization_code&code={bungieID}'
    headers = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Basic NDI0MzI6Q08tWGNaOVhOSUltQXdjSy5wa0VyQ1hWekF2SFNocmluMGYuOGVjWWlKTQ=='
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    data = response.text

    class Payload(object):
        def __init__(self, data):
            self.__dict__ = json.loads(data)

    p = Payload(data)

    refreshCode = p.refresh_token

    print("\nYour refresh code is " + refreshCode)



if __name__ == "__main__":
    main()