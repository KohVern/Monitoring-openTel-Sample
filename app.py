from flask import Flask
from prometheus_client import Counter, generate_latest
import time

app = Flask(__name__)
REQUESTS = Counter('http_requests_total', 'Total Http Requests')

@app.route('/')
def hello():
    REQUESTS.inc()
    return "Hello, World"

@app.route('/metrics')
def metrics():
    return generate_latest()

app.run(host='0.0.0.0', port=5000)
