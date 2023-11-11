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
            lat = i['_embedded']['venues'][0]['location']['latitude']
            long = i['_embedded']['venues'][0]['location']['longitude']
            # print(eventname)
            eventList.append({'name': eventname, 'lat': lat, 'long': long})
        pprint(eventList)
TicketMasterServices.run_get_tickets()