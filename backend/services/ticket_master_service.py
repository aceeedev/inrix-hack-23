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
            eventURL = i['url']
            eventDate = i['dates']['start']['localDate']

            # added coordinates to the dictionary
            lat = i['_embedded']['venues'][0]['location']['latitude']
            long = i['_embedded']['venues'][0]['location']['longitude']

            # adding the address as another item in each dictionary
            address = i['_embedded']['venues'][0]['address']['line1']
            city = i['_embedded']['venues'][0]['city']['name']
            state = i['_embedded']['venues'][0]['state']['stateCode']
            location = address + ", " + city + ", " + state

            # imagelist is a list of the images 
            imagelist = ""
            for j in i['images']:
                # try to add the first image with a 4:3 aspect ratio
                # if we can't find it just add the first image
                try:
                    if j['ratio'] != "" and j['ratio'] == '4_3':
                        imagelist = (j['url'])
                except:
                    imagelist = (j['url'])
        
            eventList.append({'name': eventname, 'eventDate': eventDate, 'lat': lat, 'long': long, 'location': location,'eventURL': eventURL, 'imagelist': imagelist})
        pprint(eventList)
        return eventList
TicketMasterServices.run_get_tickets()