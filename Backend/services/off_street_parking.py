class OffStreetParking: 
    def clean_parking(self, id = None, hrs = None, cords = None, distance = None, building_address = None, occupancy = None) -> None:
        return {
            "id": id,
            "hrs": hrs,
            "cords": cords,
            "distance": distance,
            "buildingAddress": building_address,
            "occupancy": occupancy,
        }