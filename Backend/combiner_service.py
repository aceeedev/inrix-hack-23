from services.inrix_service import InrixServices
from services.google_maps_service import GoogleMapsService
from pprint import pprint
import heapq

class CombinerService: 
    
    def __init__(self) -> None:
        self._inrix_service = InrixServices()
        self._google_maps_service = GoogleMapsService()
        
    def get_all_parking_options(self, lat_source, long_source, lat_dest, long_dest, radius) -> list[any]:
        parking_options = self._inrix_service.run_get_parking(lat_dest, long_dest, radius)

        route_options_to_concert = []

        print(len(parking_options))
        
        for parking in parking_options: 
            parking_long, parking_lat = parking["cords"]
        
            route_option_to_concert = self._google_maps_service.run_get_route(parking_lat, parking_long, lat_dest, long_dest)
            route_option_to_parking = self._google_maps_service.run_get_route(lat_source, long_source, parking_lat, parking_long, mode="driving")
            route_option_to_parking["steps"] = self._flatten_nested_cords(route_option_to_parking["steps"])
            route_states = {
                "totalTime": route_option_to_concert["time"] + route_option_to_parking["time"],
                "totalTimeText": self._format_time_text(route_option_to_concert["time"] + route_option_to_parking["time"]),
                "routeToParking": route_option_to_parking,
                "routeToEvent": route_option_to_concert,
                "totalFare": self._format_total_fare(route_option_to_concert["fare"], route_option_to_parking["fare"])
            }
        
            route_options_to_concert.append(route_states)
        
        return heapq.nsmallest(n=(min(5, len(route_options_to_concert))), iterable=route_options_to_concert, key=lambda x: int(x["routeToEvent"]["time"]))
        
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
    
    def _format_total_fare(self, fare1, fare2) -> int:
        if not fare1: fare1 = 0
        if not fare2: fare2 = 0
        return fare1 + fare2
    
    def _flatten_nested_cords(self, steps) -> list:
        res = []
        for step in steps:
            res.extend(step["path"][::5])
        return res
        
    
# driver = CombinerService()
# res = driver.get_all_parking_options(100, 100, 37.8024, -122.4058, 500)
# print(res)