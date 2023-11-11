from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/")
def test():
    return "Hello World"

app.run()