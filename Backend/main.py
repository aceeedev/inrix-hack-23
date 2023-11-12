from flask import Flask, request, jsonify
from services.ticket_master_service import TicketMasterServices
#from services.parking_service import ParkingService

app = Flask(__name__)

@app.route("/")
def home():
    return "Home of Swifty Service"

@app.route("/tickets")
def get_tickets():
    return TicketMasterServices.run_get_tickets()

@app.route("/off-street")
def get_off_street_parking():
    parking_service = ParkingService()
    
app.run(host="0.0.0.0")