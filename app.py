from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/nosotros')
def nosotros():
    return render_template("nosotros.html")

@app.route('/vocaloid')
def vocaloid():
    return render_template("vocaloid.html")

@app.route('/fuente_sonido')
def fuente_sonido():
    return render_template("fuente_sonido.html")


if __name__ == "__main__":
    app.run(debug=True)