import requests
from pprint import pprint
import json
from credentials_service import CredentialsService
from datetime import datetime as dt

class InrixServices:
    def __init__(self) -> None:
        self._credential_services = CredentialsService()
        
    def run_get_parking(self, lat, long, radius, start_time, end_time): 
        url = 'https://api.iq.inrix.com/lots/v3'

        headers = {'Authorization': "Bearer" + self._credential_services.get_token(),
                   'accept': "application/json"
        }

        payload = {'point': str(lat) + "|" + str(long),
                   'radius': str(radius),
                   'locale': 'en-US',
                   'limit': str(200),
                   }

        response = requests.get(url=url, headers=headers, params=payload)
        response = response.json()
        
        # filter 

        with open("parking.json", "w") as outfile:
            json.dump(response, outfile)

        pprint(response)
        
    def _query_parking(self) -> json:
        token = self._credential_services.get_token()
        
    def _good_parking(self, start_time, end_time) -> bool:
        # non-restricted and non-free and spaces > 20 and hours within start and end time 
        pass

    def _filter_parking(self, results, start_time, end_time) -> list[any]:
        pass

InrixServices.run_get_parking(37.7773, -122.4196, 5000)