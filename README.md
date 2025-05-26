# Proyecto Final: Rediseño Web de Crypton Future Media Inc.

Rediseño y desarrollo de la página web oficial de **Crypton Future Media Inc.** como parte de un proyecto académico de desarrollo de aplicaciones web, aplicando principios de usabilidad y diseño UX/UI para alinearla con los patrones de navegación y estilo visual del mundo occidental.

## 📌 Descripción

Este proyecto consistió en adaptar el sitio web de Crypton Future Media Inc. a las expectativas del público occidental, mejorando la experiencia del usuario mediante una interfaz moderna, navegación intuitiva y diseño responsivo.

## 🛠️ Tecnologías utilizadas

* **Python** con **Flask** como framework backend.
* **HTML5**, **CSS3** y **JavaScript** para el frontend.
* **Bootstrap** para diseño responsivo.
* **MySQL** como sistema de gestión de bases de datos.
* **Jinja2** para renderizado de plantillas.
* **SQLAlchemy** para la gestión de la base de datos.([GitHub][1])

## 📁 Estructura del proyecto

Proyecto-Final-Desarrollo-de-Aplicaciones-Web/
├── app.py
├── templates/
│   ├── base.html
│   ├── index.html
│   └── ...
├── static/
│   ├── css/
│   ├── js/
│   └── images/
├── Crypton.sql
├── StoredProcedures.sql
├── venv/
└── README.md

## 🚀 Instalación y ejecución local

1. Clona el repositorio:
   git clone https://github.com/MargaritaCuervo/Proyecto-Final-Desarrollo-de-Aplicaciones-Web.git
   
2. Accede al directorio del proyecto:
  cd Proyecto-Final-Desarrollo-de-Aplicaciones-Web

3. Crea y activa un entorno virtual:
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate

4. Instala las dependencias:
pip install -r requirements.txt

5. Configura la base de datos MySQL:
* Crea una base de datos llamada `crypton`.
* Importa el archivo `Crypton.sql` para crear las tablas necesarias.
* (Opcional) Importa `StoredProcedures.sql` para agregar procedimientos almacenados.

6. Ejecuta la aplicación:
   python app.py

7. Abre tu navegador y visita `http://localhost:5000` para ver la aplicación en funcionamiento.

## 👥 Autores

* **Margarita Cuervo**
* **Luz Colunga**
* **José Moreno**
* **Carlos Navarro** (repositorio original)

## 📄 Licencia

Este proyecto se desarrolló con fines académicos y no está destinado para uso comercial.([GitHub][1])

