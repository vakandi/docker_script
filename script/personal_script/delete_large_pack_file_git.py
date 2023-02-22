#run : python delete_file.py path/to/file.pack owner repo

import requests
import json
import sys

# GitHub API endpoint for deleting a file
API_ENDPOINT = "https://api.github.com/repos/{OWNER}/{REPO}/contents/{FILEPATH}"

# GitHub access token (generate one from https://github.com/settings/tokens)
TOKEN = "YOUR_TOKEN"

# Get the filepath to delete from the command line arguments
filepath = sys.argv[1]

# Get the owner and repository from the command line arguments
owner = sys.argv[2]
repo = sys.argv[3]

# Replace placeholders in the API endpoint with the actual values
url = API_ENDPOINT.replace("{OWNER}", owner).replace("{REPO}", repo).replace("{FILEPATH}", filepath)

# Send a GET request to the GitHub API to get the SHA of the file
response = requests.get(url, headers={'Authorization': 'Token ' + TOKEN})

# Parse the JSON response
data = json.loads(response.text)

# Get the SHA of the file
sha = data["sha"]

# Send a DELETE request to the GitHub API to delete the file
response = requests.delete(url, json={'sha': sha}, headers={'Authorization': 'Token ' + TOKEN})

# Print the status code of the response
print(response.status_code)

