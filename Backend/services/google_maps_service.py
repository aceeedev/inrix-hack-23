import requests
from pprint import pprint
import json
import polyline

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

        start_info = response["routes"][0]["legs"][0]["start_address"]
        end_info = response["routes"][0]["legs"][0]["end_address"]
        try:
            fare = response["routes"]["fare"]["text"]
        except:
            fare = None


        points = []

        for step in response["routes"][0]["legs"][0]["steps"]:

            poly = polyline.decode(step["polyline"]["points"])
            points.extend(poly)

            # try:
            #     sub_points = []
            #     for sub_step in step["steps"]:
            #         lat = sub_step["start_location"]["lat"]
            #         long = sub_step["start_location"]["lng"]
            #         sub_points.append([lat, long])
            #     points.append(sub_points)

            # except:
            #     lat = step["start_location"]["lat"]
            #     long = step["start_location"]["lng"]
            #     points.append([[lat, long]])

        pprint(points)

        return {"start": start_info, "end": end_info, "fare": fare, "points": points}

        print(points)

        with open("transit.json", "w") as outfile:
            json.dump(response, outfile)

        pprint(response)
        

GoogleMapsService.run_get_transit_route(37.7786, -122.3893, 37.8024, -122.4058)