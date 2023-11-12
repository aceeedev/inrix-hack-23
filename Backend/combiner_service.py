from services.inrix_service import InrixServices
from services.google_maps_service import GoogleMapsService
from pprint import pprint
import heapq

class CombinerService: 
    
    def __init__(self) -> None:
        self._inrix_service = InrixServices()
        self._google_maps_service = GoogleMapsService()
        
    def get_all_parking_options(self, lat_source, long_source, lat_dest, long_dest, radius, start_time) -> list[any]:
        parking_options = self._inrix_service.run_get_parking(lat_dest, long_dest, radius, start_time)

        route_options_to_concert = []

        print(len(parking_options))
        
        for parking in parking_options: 
            parking_long, parking_lat = parking["cords"]
            print("DEBUG: parking lat long ", parking_long, parking_lat)
            # print("DEBUG: here")
            route_option_to_concert = self._google_maps_service.run_get_route(parking_lat, parking_long, lat_dest, long_dest)
            route_option_to_parking = self._google_maps_service.run_get_route(lat_source, long_source, parking_lat, parking_long, mode="driving")
            route_option_to_parking["steps"] = route_option_to_parking["steps"][0]
            print("DEBUG2: ", parking["cost"])
            route_states = {
                "totalTime": route_option_to_concert["time"] + route_option_to_parking["time"],
                "totalTimeText": self._format_time_text(route_option_to_concert["time"] + route_option_to_parking["time"]),
                "parkingCost": parking["cost"],
                "routeToParking": route_option_to_parking,
                "routeToEvent": route_option_to_concert,
            }
        
            route_options_to_concert.append(route_states)
        
        return heapq.nsmallest(n=(min(5, len(route_options_to_concert))), iterable=route_options_to_concert, key=lambda x: int(x["routeToEvent"]["time"]))
        # return heapq.nsmallest(n=(min(5, len(route_options_to_concert))), iterable=route_options_to_concert, key=lambda x: ((int(x["routeToEvent"]["time"])/60)**2)  + (int(x["parkingCost"])**2))
        
    def _format_time_text(self, seconds: int) -> str: 
        res = "" 
        hrs = seconds // 3600
        minutes = seconds % 3600
        if hrs >= 1:
            res += str(seconds // 3600)
            if hrs == 1:
                res += " hr"
            else:
                res += " hrs"
            
            seconds //= 3600
        
        if minutes >= 1:
            res += " " + str(minutes // 60)
            if hrs == 1:
                res += " min"
            else:
                res += " mins"
        return res

        
        
    
# driver = CombinerService()
# res = driver.get_all_parking_options(37.349005996578114, -121.936651011974, 37.8024, -122.4058, 2500, "2023-11-12T00:00")
# pprint(res)