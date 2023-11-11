from flask import Flask, request, jsonify
from services.class3 import TicketMasterServices

app = Flask(__name__)

@app.route("/tickets")
def get_tickets():
    return TicketMasterServices.run_get_tickets()
    
app.run()