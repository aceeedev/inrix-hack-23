from services.inrix_service import InrixServices
from services.google_maps_service import GoogleMapsService
from pprint import pprint
import heapq

class CombinerService: 
    
    def __init__(self) -> None:
        self._inrix_service = InrixServices()
        self._google_maps_service = GoogleMapsService()
        
    def get_all_parking_options(self, lat_dest, long_dest, radius) -> list[any]:
        parking_options = self._inrix_service.run_get_parking(lat_dest, long_dest, radius)

        route_options = []
        print(len(parking_options))
        
        for parking in parking_options: 
            parking_long, parking_lat = parking["cords"]
            print("DEBUG: parking lat long ", parking_long, parking_lat)
            # print("DEBUG: here")
            route_option = self._google_maps_service.run_get_route(parking_lat, parking_long, lat_dest, long_dest)
        
            route_options.append(route_option)

        return heapq.nsmallest(n=(min(5, len(route_options))), iterable=route_options, key=lambda x: int(x["time"]))
        
    
    
# driver = CombinerService()
# res = driver.get_all_parking_options(100, 100, 37.8024, -122.4058, 500)
# print(res)