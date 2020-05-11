#!/usr/bin/env python3
from flask import Flask, request

import subprocess

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def home():
    return "Not a valid API endpoint.", 404

@app.route('/ping', methods=['GET'])
def api_ping():
    return "pong"

@app.route('/post', methods=['POST'])
def api_post():
    data = request.get_json()
    command = "jrnl now: " + data["msg"]
    try:
        process = subprocess.check_output([command], shell=True)
        return "Entry added."
    except subprocess.CalledProcessError:
        return "An error occurred."

@app.errorhandler(404)
def page_not_found(e):
    return "The resource could not be found.", 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=False)

