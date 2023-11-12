import requests
from pprint import pprint
import json

from credentials_service import CredentialsService

class GoogleMapsService:

    def run_get_transit_route(lat1, long1, lat2, long2, departure_time=None): 
        url = 'https://maps.googleapis.com/maps/api/directions/json'

        payload = {'key': CredentialsService().GOOGLE_API_KEY,
                   'origin': str(lat1) + " ," + str(long1),
                   'destination': str(lat2) + " ," + str(long2),
                   'mode': "transit",
                   }

        response = requests.get(url=url, params=payload)
        response = response.json()
        
        # filter 

        with open("transit.json", "w") as outfile:
            json.dump(response, outfile)

        pprint(response)
        

GoogleMapsService.run_get_transit_route(37.7786, -122.3893, 37.8024, -122.4058)