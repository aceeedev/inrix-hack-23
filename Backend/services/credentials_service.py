from dotenv import dotenv_values
from datetime import datetime as dt
import requests

# Call get_token for a bearer token. Can get any attribute directly such as APP_ID and APP_KEY
class CredentialsService: 
    def __init__(self) -> None:
        credentials = dotenv_values(".env")
        self.APP_ID = "2lsj0ylb5d"
        self.APP_KEY = "hZkt5ZDvL5aivF95xUJhU9aMjMyjmvUU98UipAJq"
        self.HASH_TOKEN = "MmxzajB5bGI1ZHxoWmt0NVpEdkw1YWl2Rjk1eFVKaFU5YU1qTXlqbXZVVTk4VWlwQUpx"
        self.format = "%Y-%m-%dT%H:%M:%S"
        self.GOOGLE_API_KEY = credentials["GOOGLE_API_KEY"]
        self.TICKET_MASTER_API_KEY = credentials["TICKET_MASTER_API_KEY"]
        self._get_new_token()
        
    def _get_new_token(self) -> None: 
        url = "https://api.iq.inrix.com/auth/v1/appToken"
        query_params = {
            "appId": self.APP_ID,
            "hashToken": self.HASH_TOKEN,
        }
        
        req = requests.get(url=url, params=query_params).json()
        self.inrix_bearer_token = req["result"]["token"]
        self.expiration_date = self._parse_inrix_expiration_date(req["result"]["expiry"])
    
    def _parse_inrix_expiration_date(self, timestamp: str) -> dt:
        return dt.strptime(timestamp[:len(timestamp)-5], self.format)
    
    def get_token(self) -> None:
        '''Validates a bearer token. If the token is expired a new one is queried'''
        if not self._valid_token():
            self.get_new_token()
        return self.inrix_bearer_token
    
    def get_google_api_key(self) -> str:
        return self.GOOGLE_API_KEY
    
    def get_ticket_master_api_key(self) -> str:
        return self.TICKET_MASTER_API_KEY
    
    def _valid_token(self) -> bool:
        now = dt.utcnow()
        return now < self.expiration_date
