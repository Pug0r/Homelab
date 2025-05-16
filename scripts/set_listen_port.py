import sys
import requests
import json
import os
from dotenv import load_dotenv

load_dotenv(dotenv_path="../.env")

SERVER_ADDRESS = os.environ.get("MAIN_SERVER_IP")
USERNAME = os.environ.get("USERNAME")
PASSWORD = os.environ.get("PASSWORD")

API_BASE = f"http://{SERVER_ADDRESS}:8080/api/v2"
LOGIN_ENDPOINT = f"{API_BASE}/auth/login"
GET_APP_STATE_ENDPOINT = f"{API_BASE}/app/preferences"
SET_APP_STATE_ENDPOINT = f"{API_BASE}/app/setPreferences"

if len(sys.argv) < 2 or not sys.argv[1].isdecimal():
    print(f"Usage: python {sys.argv[0]} port_number")
    sys.exit(1)

portNumberToSet = int(sys.argv[1])
preferences = json.dumps({"listen_port": portNumberToSet})

with requests.Session() as s:
    resp = s.post(LOGIN_ENDPOINT, data={'username':USERNAME, 'password':PASSWORD})
    if (resp.status_code != 200):
        print("Could not log in to qbittorrent.")
        sys.exit(1)
    resp = s.get(GET_APP_STATE_ENDPOINT)
    if (resp.json()['listen_port'] != portNumberToSet):
        response = s.post(SET_APP_STATE_ENDPOINT, data={"json": preferences})
        if (response.status_code != 200):
            print(f"Could not set port number to {portNumberToSet}.")
            sys.exit(1)
sys.exit(0)
