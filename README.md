## Inspiration
The atmosphere and energy of live concerts create memorable moments for fans to connect with their favorite artists. But traffic congestion and the stress of transportation can quickly take away from a once-in-a-lifetime experience. Planning a commute is tedious: parking is expensive and difficult to find, and no one wants to walk several miles! This app takes care of the stress so all you have to do is “Park, Bus, and Jam!”

## What it does
A concert commute can be split into 3 components: driving, parking, and transit. PB&J designs a full trip including commuting to a parking space and taking public transit to your venue. The app is synced to the Ticket Master event database, so all you need to do is search for your event and the trip can be calculated automatically. Additionally, PB&J will give you multiple valid parking and route options to choose from, each optimized for both cost and time.

## How we built it
Firstly, the TicketMaster API allows PB&J to access event data to automatically plan routes for your venue. Then, we take the geolocation and start time of the event, and use the INRIX Parking API to find valid parking spots in a nearby radius. Thirdly, we use the Google Directions API to calculate transit fares and times given each parking spot. We sort through the combinations of parking and transit to deliver 5 optimal locations based on both total price and travel time.

## Challenges we ran into
While the Google Directions API to plan transit routes is convenient, it is very slow. We wanted to download and save GTFS data (“General Transit Feed Specification” data, which is an open standard for the exchange of transit systems information) so that our calls can be made locally and with more customizable traversals. However, this proved difficult given our time constraints. Similarly, we wanted to provide more features on the client side such as the ability to search concerts by genre and a slider to estimate your stay at the venue (since most events don’t have specific end times). However, we continued to be challenged by the implementation of our algorithms and other key features in combining the frontend with the backend, so we couldn’t get to work on these implementations in time.

## Accomplishments that we're proud of
We are proud to have connected multiple different API data sets in unique and robust ways. For the backend, this meant returning aggregated data from multiple real-time sources in a neat format. For the frontend, this meant toggling certain features based on API calls.

## What we learned
There were many different features we thought about adding to our app; however, we learned how to prioritize the most important features to get the app delivered within our time limit. To this end, we learned how to wear many different hats and keep ourselves productive by continuously developing different parts of the codebase where needed.

## What's next for "PB&J" (Park, Bus, and Jam)
As mentioned before, in the future, PB&J will be optimized with its own local GTFS database to refer to. This would remove the latency due to API calls over the internet as well as speed since the app would have greater control over the type of traversals along transit routes it could make. Another solution, In terms of interface, PB&J will add a lot more features and parameters to further customize the venue commute experience.
