from flask import Flask, render_template, request, redirect, url_for, session
import hashlib
from flask_mysqldb import MySQL

app = Flask(__name__)
mysql = MySQL(app)
app.secret_key = '666'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'crypton_db'

@app.route('/')
def index():
    if 'username' in session:
        return render_template('index.html',username=session['username'])
    else:
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

@app.route('/log_in',methods=['GET','POST'])
def log_in():
    if request.method=='POST':
        username = request.form['username']
        password = request.form['password']
        hshpass = hashlib.sha256(password.encode()).hexdigest()
        cursor = mysql.connection.cursor()
        cursor.callproc('login',(username,hshpass))
        result = cursor.fetchone()
        cursor.close()
        if result:
            session['username'] = result[0]
            return redirect(url_for('index'))
        else:
            cursor.close()
            error = 'Usuario o contraseña incorrectos'
            return render_template("log_in.html",error=error)
    else:
        return render_template("log_in.html")

@app.route('/logout')
def logoout():
    session.pop('username',None)
    return redirect(url_for('index'))

@app.route('/sign_up')
def sign_up():
    return render_template("sign_up.html")

@app.route('/politica_privacidad')
def politica_privacidad():
    return render_template("politica_privacidad.html")

@app.route('/politica_uso')
def politica_uso():
    return render_template("politica_uso.html")

@app.route('/contactanos')
def contactanos():
    return render_template("contactanos.html")

@app.route('/preguntas')
def faqs():
    return render_template("preguntas.html")

if __name__ == "__main__":
    app.run(debug=True)