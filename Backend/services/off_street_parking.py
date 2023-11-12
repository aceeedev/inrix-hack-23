class OffStreetParking: 
    def clean_parking(self, id = None, name = None, hrs = None, cords = None, distance = None, building_address = None, occupancy = None) -> None:
        return {
            "id": id,
            "name": name,
            "hrs": hrs,
            "cords": cords,
            "distance": distance,
            "buildingAddress": building_address,
            "occupancy": occupancy,
        }