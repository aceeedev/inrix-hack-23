import requests
from pprint import pprint
class TicketMasterServices:

    def run_get_tickets(): 
        url = 'https://app.ticketmaster.com/discovery/v2/events'
        payload = {'apikey': "5eNZUfknq3JGAOjAJT2zyaJ6x8i5wqcG", 'city': "San Francisco", 'classificationName': "music"}

        response = requests.get(url=url, params=payload)
        response = response.json()
        eventList = []

        for i in response['_embedded']['events']:
            eventname = i['name']
            # added coordinates to the dictionary
            lat = i['_embedded']['venues'][0]['location']['latitude']
            long = i['_embedded']['venues'][0]['location']['longitude']
            # adding the address as another item in each dictionary
            address = i['_embedded']['venues'][0]['address']['line1']
            city = i['_embedded']['venues'][0]['city']['name']
            state = i['_embedded']['venues'][0]['state']['stateCode']
            location = ""
            location = address + ", " + city + ", " + state
            # imagelist is a list of the images 
            # imagelist = 
            eventList.append({'name': eventname, 'lat': lat, 'long': long, 'location': location})
        pprint(eventList)
TicketMasterServices.run_get_tickets()