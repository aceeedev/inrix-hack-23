from flask import Flask, request, jsonify
from services.ticket_master_service import TicketMasterServices
from services.inrix_service import InrixServices
from combiner_service import CombinerService


app = Flask(__name__)

@app.route("/")
def home():
    return "Home of Swifty Service"

@app.route("/tickets")
def get_tickets():
    return jsonify(TicketMasterServices.run_get_tickets()), 200

@app.route("/parking-options")
def get_parking_options():
    lat_source = request.args.get("latSource", default = 0, type=float)
    long_source = request.args.get("longSource", default = 0, type=float)
    lat_dest = request.args.get("latDest", default = 0, type=float)
    long_dest = request.args.get("longDest", default = 0, type=float)
    start_time = request.args.get("startTime", default ="", type=str)
    radius = request.args.get("radius", default = 0, type=float)
    
    combiner_service = CombinerService()
    print(lat_dest, long_dest, radius)
    res = combiner_service.get_all_parking_options(lat_source, long_source, lat_dest=lat_dest, long_dest=long_dest, radius=radius, start_time=start_time)    
    if not res:
        print("here")
        return jsonify({"message": "internal service error"}, 500)
    return (jsonify(res, 200))

@app.route("/off-street")
def get_off_street_parking():
    lat = request.args.get('lat', default = 0, type = float)
    long =  request.args.get('long', default = 0, type = float)
    radius = request.args.get("radius", default=1500, type=float)
    
    inrix_service = InrixServices()
    return jsonify(inrix_service.run_get_parking(lat, long, radius)), 200

    
app.run(host="0.0.0.0")