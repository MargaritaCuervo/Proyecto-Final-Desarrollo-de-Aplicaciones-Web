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

@app.route('/cd_muestra')
def cd_muestra():
    return render_template("cd_muestra.html")

@app.route('/bibliotecas')
def bibliotecas():
    return render_template("bibliotecas.html")

@app.route('/log_in')
def log_in():
    return render_template("log_in.html")

@app.route('/sign_up')
def sign_up():
    return render_template("sign_up.html")

@app.route('/politica_privacidad')
def politica_privacidad():
    return render_template("politica_privacidad.html")

@app.route('/politica_uso')
def politica_uso():
    return render_template("politica_uso.html")


if __name__ == "__main__":
    app.run(debug=True)