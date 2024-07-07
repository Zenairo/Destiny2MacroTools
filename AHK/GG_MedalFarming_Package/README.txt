# Destiny 2 Python API Interaction

## Setup Instructions

To use this script, follow the steps below:

1. **Install Python**:
    - Download and install Python from the [official website](https://www.python.org/).
    - Open your command prompt and run:
      ```sh
      python -m pip install requests
      ```

2. **Navigate to the Script Directory**:
    - Change your directory to where you downloaded the folder. For example:
      ```sh
      cd Desktop\Python API Scripts
      ```

3. **Get Your Refresh Token**:
    - Run the following command and follow the instructions:
      ```sh
      python get-refresh-token.py
      ```

4. **Edit the Python File**:
    - Open `check-for-bounty.py` and set the `refreshCode` variable to the refresh token you were given.
    - Set the `bungieID` variable to your ID from your Bungie.net profile page.
      - For example, if your profile URL is `https://www.bungie.net/7/en/User/Profile/3/1111111111111111111?bgn=Guardian`, your ID would be `1111111111111111111`.

5. **Run the Bounty Checker**:
    - Execute the script with the command:
      ```sh
      python check-for-bounty.py
      ```

Use check-for-bounty.py as an example of how to query the D2 API for certain bounties and their progress.
Exit codes can be used to determine the result from another AHK script, as shown in integration.ahk.