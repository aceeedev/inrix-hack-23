import requests
from pprint import pprint
import json
from credentials_service import CredentialsService
from datetime import datetime as dt
from models.off_street_parking import OffStreetParking

class InrixServices:
    def __init__(self) -> None:
        self._credential_services = CredentialsService()
        
    def run_get_parking(self, lat, long, radius, start_time = None, end_time = None): 
        # url = 'https://api.iq.inrix.com/lots/v3'

        # headers = {'Authorization': "Bearer" + self._credential_services.get_token(),
        #            'accept': "application/json"
        # }

        # payload = {'point': str(lat) + "|" + str(long),
        #            'radius': str(radius),
        #            'locale': 'en-US',
        #            'limit': str(200),
        #            }

        # response = requests.get(url=url, headers=headers, params=payload)
        # response = response.json()
        return self._query_parking(lat, long, radius, start_time, end_time)
    
        
    def _query_parking(self, lat: str, long: str, radius: float, start_time = None, end_time = None) -> json:
        token = self._credential_services.get_token()
        url = 'https://api.iq.inrix.com/lots/v3'

        headers = {
            'Authorization': "Bearer" + token,
            'accept': "application/json"
        }
        
        payload = {
            'point': str(lat) + "|" + str(long),
            'radius': str(radius),
            'locale': 'en-US',
            'limit': str(200),
        }

        response = requests.get(url=url, headers=headers, params=payload)
        status_code = response.status_code
        if status_code != 200:
            return "error in request"
        
        data = response.json()["result"]
        return self._filter_parking(data)
        
    def _good_parking(self, option: json, start_time = None, end_time = None) -> bool:
        # non-restricted and non-free and spaces > 20 and hours within start and end time 
        valid_spot = option["type"] != "Restricted" and option["spacesTotal"] >= 20 
        return valid_spot

    def _filter_parking(self, results, start_time = None, end_time = None) -> list[any]:
        return [result for result in results if self._good_parking(result, start_time, end_time)]
    
    def _extract_parking_data(self, result) -> off_street_parking:
        return off_street_parking
            

driver = InrixServices()
res = driver.run_get_parking(37.74638779388551, -122.42209196090698, 1500)

pprint(res)
print(len(res))