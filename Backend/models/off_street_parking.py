class OffStreetParking: 
    def __init__(self, id, hrs, cords, distance, building_address) -> None:
        self.parking = {
            "id": id,
            "hrs": hrs,
            "cords": cords,
            "distance": distance,
            "building_address": building_address,
        }
        
    def debug(self) -> str:
        print(self.parking)