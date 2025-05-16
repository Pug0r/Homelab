import sys
import os 
import requests
from dotenv import load_dotenv

load_dotenv(dotenv_path="../.env")
SERVER_ADDRESS = os.environ.get("MAIN_SERVER_IP")
USERNAME = os.environ.get("USERNAME")
PASSWORD = os.environ.get("PASSWORD")

API_BASE = f"http://{SERVER_ADDRESS}:8080/api/v2"
LOGIN_ENDPOINT = f"{API_BASE}/auth/login"
GET_SPEED_ENDPOINT = f"{API_BASE}/transfer/speedLimitsMode"
TOGGLE_SPEED_ENDPOINT = f"{API_BASE}/transfer/toggleSpeedLimitsMode"

if len(sys.argv) < 2 or sys.argv[1] not in ('0', '1'):
    print(f"Usage: python {sys.argv[0]} <1|0>")
    sys.exit(1)

stateToSet = sys.argv[1]

with requests.Session() as s:
    resp = s.post(LOGIN_ENDPOINT, data={'username':USERNAME, 'password':PASSWORD})
    if (resp.status_code != 200):
        print("Could not log in to qbittorrent.")
        sys.exit(1)
    resp = s.get(GET_SPEED_ENDPOINT)
    if (resp.text != stateToSet): 
        resp = s.post(TOGGLE_SPEED_ENDPOINT)
        if (resp.status_code != 200):
            print("Could not switch speed limits.")
            sys.exit(1)
sys.exit(0)
