from flask import Flask, render_template, request, redirect, url_for, session, jsonify
import hashlib
from flask_mysqldb import MySQL

app = Flask(__name__)
mysql = MySQL(app)
app.secret_key = '666'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '120704'
app.config['MYSQL_DB'] = 'Crypton'

@app.route('/')
def index():
    if 'username' in session:
        return render_template('index.html', username=session['username'])
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

@app.route('/log_in', methods=['GET', 'POST'])
def log_in():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        hshpass = hashlib.sha256(password.encode()).hexdigest()
        cursor = mysql.connection.cursor()
        try:
            cursor.callproc('login', (username, hshpass))
            result = cursor.fetchone()
            cursor.close()
        except Exception as e:
            cursor.close()
            error = f'Error al iniciar sesión: {str(e)}'
            return render_template("log_in.html", error=error)

        if result and result[0] == 'Login successful':
            session['username'] = username
            return redirect(url_for('index'))
        else:
            error = 'Usuario o contraseña incorrectos'
            return render_template("log_in.html", error=error)
    else:
        return render_template("log_in.html")

@app.route('/logout')
def logoout():
    session.pop('username', None)
    return redirect(url_for('index'))

@app.route('/sign_up', methods=['GET', 'POST'])
def sign_up():
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        telefono = request.form['telefono']
        usuario = request.form['user']
        correo = request.form['correo']
        password = request.form['password']
        hshpass = hashlib.sha256(password.encode()).hexdigest()
        cursor = mysql.connection.cursor()
        try:
            cursor.callproc('signup', (nombre, apellido, correo, telefono, usuario, hshpass))
            result = cursor.fetchone()
            cursor.close()
            mysql.connection.commit()
        except Exception as e:
            cursor.close()
            error = f'Registro fallido: {str(e)}'
            return render_template("sign_up.html", error=error)

        if result and result[0] == 'Sign up successful':
            return redirect(url_for('log_in'))
        else:
            error = 'Registro fallido: El usuario ya existe'
            return render_template("sign_up.html", error=error)
    else:
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


@app.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    if 'username' not in session:
        return jsonify({'message': 'Debe iniciar sesión para agregar productos al carrito.'}), 401

    data = request.get_json()
    product_id = data['productId']
    
    cursor = mysql.connection.cursor()
    try:
        # Obtener el client_ID del usuario
        cursor.execute('SELECT client_ID FROM ClientesLogins WHERE client_user = %s', [session['username']])
        user_id = cursor.fetchone()[0]

        # Verificar si el usuario ya tiene un pedido abierto
        cursor.execute('SELECT order_id FROM Pedidos WHERE client_ID = %s AND order_total = 0', [user_id])
        order = cursor.fetchone()

        if not order:
            # Crear un nuevo pedido si no existe uno abierto
            cursor.execute('INSERT INTO Pedidos (client_ID, order_date, order_total) VALUES (%s, CURDATE(), 0)', [user_id])
            mysql.connection.commit()
            order_id = cursor.lastrowid
        else:
            order_id = order[0]

        # Insertar el producto en DetallesPedidos
        cursor.execute('INSERT INTO DetallesPedidos (product_ID, order_id) VALUES (%s, %s)', (product_id, order_id))
        mysql.connection.commit()
        cursor.close()

        return jsonify({'message': 'Producto agregado al carrito.'})
    except Exception as e:
        print(f'Error: {e}')
        cursor.close()
        return jsonify({'message': 'Hubo un problema al agregar el producto al carrito.'}), 500



@app.route('/carrito')
def carrito():
    if 'username' not in session:
        return redirect(url_for('log_in'))

    cursor = mysql.connection.cursor()
    cursor.execute('''
        SELECT p.product_name, p.product_price, d.detail_ID, d.product_ID
        FROM Productos p
        JOIN DetallesPedidos d ON p.product_ID = d.product_ID
        JOIN Pedidos o ON d.order_id = o.order_id
        JOIN ClientesLogins c ON o.client_ID = c.client_ID
        WHERE c.client_user = %s
    ''', [session['username']])

    productos = cursor.fetchall()
    cursor.execute('''
        SELECT SUM(p.product_price) as total
        FROM Productos p
        JOIN DetallesPedidos d ON p.product_ID = d.product_ID
        JOIN Pedidos o ON d.order_id = o.order_id
        JOIN ClientesLogins c ON o.client_ID = c.client_ID
        WHERE c.client_user = %s
    ''', [session['username']])

    total = cursor.fetchone()[0]
    cursor.close()
    
    return render_template('carrito.html', products=productos, order_total=total)



@app.route('/remove_from_cart/<int:detail_id>', methods=['POST'])
def remove_from_cart(detail_id):
    cursor = mysql.connection.cursor()
    cursor.execute('DELETE FROM DetallesPedidos WHERE detail_ID = %s', [detail_id])
    mysql.connection.commit()
    cursor.close()
    return redirect(url_for('carrito'))




if __name__ == "__main__":
    app.run(debug=True)
