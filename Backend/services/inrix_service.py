import requests
import json
from services.credentials_service import CredentialsService
from services.off_street_parking import OffStreetParking

class InrixServices:
    def __init__(self) -> None:
        self._credential_services = CredentialsService()
        
    def run_get_parking(self, lat: float, long: float, radius: float, start_time = None, end_time = None): 
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
            'radius': int(radius),
            'locale': 'en-US',
            'limit': 50,
        }

        response = requests.get(url=url, headers=headers, params=payload)
        status_code = response.status_code
        if status_code != 200:
            return {"message": "error in request", "statusCode": status_code}
        
        data = response.json()["result"]
        return self._filter_parking(data)
        
    def _good_parking(self, option: json, start_time = None, end_time = None) -> bool:
        # non-restricted and non-free and spaces > 20 and hours within start and end time 
        valid_spot = option["type"] != "Restricted" and option["spacesTotal"] >= 20 
        return valid_spot

    def _filter_parking(self, results, start_time = None, end_time = None) -> list[any]:
        return [self._extract_parking_data(result) for result in results if self._good_parking(result, start_time, end_time)]
    
    def _extract_parking_data(self, result) -> OffStreetParking:
        try: 
            id = result["id"]
        except: 
            id = None
        
        try: 
            name = result["name"]
        except: 
            name = None
        
        try: 
            hrs = result["hrs"]
        except: 
            hrs = None
            
        try: 
            cords = result["point"]["coordinates"]
        except:
            cords = None
        
        try: 
            distance = result["distance"]
        except: 
            distance = None
            
        try: 
            building_address = result["buildingAddress"]
        except:
            building_address = None
        
        try: 
            occupancy = result["occupancy"]
        except:
            occupancy = None
        
        return OffStreetParking().clean_parking(
            id = id,
            name = name,
            hrs = hrs,
            cords = cords,
            distance = distance,
            building_address= building_address,
            occupancy = occupancy,          
        )
