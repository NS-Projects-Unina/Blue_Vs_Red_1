import os
import time
from flask import Flask, jsonify
import redis

app = Flask(__name__)

# Connessione a Redis
redis_host = os.environ.get("REDIS_HOST", "localhost")
r = redis.Redis(host=redis_host, port=6379, decode_responses=True)

# Inizializza la flag nel DB all'avvio
FLAG_VALORE = "FLAG{H34rtbl33d_Thru_R3d1s_C4ch3}"
r.set("challenge_flag", FLAG_VALORE)

@app.route('/')
def index():
    return "Benvenuto sul portale aziendale. Area protetta attiva."

@app.route('/admin')
def admin():
    # Preleva la flag dal Database Redis
    flag_da_db = r.get("challenge_flag")
    return jsonify({
        "status": "success",
        "session": "admin_authenticated_session_string",
        "secret_flag": flag_da_db
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)