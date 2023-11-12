from flask import Flask, request, jsonify
from services.ticket_master_service import TicketMasterServices

app = Flask(__name__)

@app.route("/")
def home():
    return "Home of Swifty Service"

@app.route("/tickets")
def get_tickets():
    return TicketMasterServices.run_get_tickets()
    
app.run()