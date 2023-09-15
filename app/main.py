"""module providing ability to run app on web server"""
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    """simple test phrase"""
    return "Slava Ukraini!"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
