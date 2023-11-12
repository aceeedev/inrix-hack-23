import requests
from pprint import pprint
import json

from credentials_service import CredentialsService

from datetime import datetime as dt

class InrixServices:

    def run_get_parking(lat, long, radius, start_time, end_time): 
        url = 'https://api.iq.inrix.com/lots/v3'

        headers = {'Authorization': "Bearer" + CredentialsService().get_token(),
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
        
    def _filter_parking(self, start_time, end_time) -> bool:
        # non-restricted and non-free and spaces > 20 and hours within start and end time 
        
        pass

InrixServices.run_get_parking(37.7773, -122.4196, 5000)