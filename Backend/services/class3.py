import requests

class TicketMasterServices:

    def run_get_tickets(): 
        url = 'https://app.ticketmaster.com/discovery/v2/events'
        payload = {'apikey': "5eNZUfknq3JGAOjAJT2zyaJ6x8i5wqcG", 'city': "San Francisco", 'classificationName': "music"}

        response = requests.get(url=url, params=payload)
        response = response.json()
        
        return response['_embedded']