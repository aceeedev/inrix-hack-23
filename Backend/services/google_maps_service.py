import requests
import json
from pprint import pprint
import polyline

from credentials_service import CredentialsService

class GoogleMapsService:

    def run_get_route(lat1, long1, lat2, long2, mode="transit", departure_time=None): 
        url = 'https://maps.googleapis.com/maps/api/directions/json'

        payload = {'key': CredentialsService().GOOGLE_API_KEY,
                   'origin': str(lat1) + " ," + str(long1),
                   'destination': str(lat2) + " ," + str(long2),
                   'mode': mode,
                   }

        response = requests.get(url=url, params=payload)
        response = response.json()
        
        # filter 

        start_info = response["routes"][0]["legs"][0]["start_address"]
        end_info = response["routes"][0]["legs"][0]["end_address"]
        time_text = response["routes"][0]["legs"][0]["duration"]["text"]
        time = response["routes"][0]["legs"][0]["duration"]["value"]
        try:
            fare_text = response["routes"][0]["fare"]["text"]
            fare = response["routes"][0]["fare"]["value"]
        except:
            fare_text = None
            fare = None

        steps = []
        for step in response["routes"][0]["legs"][0]["steps"]:

            poly = polyline.decode(step["polyline"]["points"])
            poly = [[x, y] for x, y in poly]

            mode = step["travel_mode"]

            if mode == "TRANSIT":
                headsign = step["transit_details"]["headsign"]
                steps.append({"mode": mode, "path": poly, "headsign": headsign})
            else:
                steps.append({"mode": mode, "path": poly})

        res = {"start": start_info, "end": end_info, "time_text": time_text, "time": time, "fare_text": fare_text, "fare": fare, "steps": steps}
        # pprint(res)

        # with open("sample.json", "w") as outfile:
        #     json.dump(res, outfile)
        return res

# GoogleMapsService.run_get_route(37.7786, -122.3893, 37.8024, -122.4058)