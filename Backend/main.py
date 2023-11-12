from flask import Flask, request, jsonify
from services.ticket_master_service import TicketMasterServices
from services.inrix_service import InrixServices


app = Flask(__name__)

@app.route("/")
def home():
    return "Home of Swifty Service"

@app.route("/tickets")
def get_tickets():
    return TicketMasterServices.run_get_tickets()

@app.route("/off-street")
def get_off_street_parking():
    lat = request.args.get('lat', default = 0, type = float)
    long =  request.args.get('long', default = 0, type = float)
    radius = request.args.get("radius", default=1500, type=float)
    
    inrix_service = InrixServices()
    return jsonify(inrix_service.run_get_parking(lat, long, radius))
    
app.run(host="0.0.0.0")