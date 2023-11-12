from services.inrix_service import InrixServices
from services.google_maps_service import GoogleMapsService

class CombinerService: 
    
    def __init__(self) -> None:
        self._inrix_service = InrixServices()
        self._google_maps_service = GoogleMapsService()
        
    def get_all_parking_options(self, lat_source, long_source, lat_dest, long_dest, radius) -> list[any]:
        parking_options = self._inrix_service.run_get_parking(lat_dest, long_dest, radius)

        route_options = []
        for parking in parking_options: 
            parking_long, parking_lat = parking["cords"]
            route_option = self._google_maps_service.run_get_route(parking_lat, parking_lat, lat_dest, long_dest)
            route_options.append(route_options)
        return route_options
    
    
driver = CombinerService()
res = driver.get_all_parking_options(100, 100, 37.8024, -122.4058, 1500)
