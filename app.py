from flask import Flask, render_template, url_for, request, redirect
from flask_mysqldb import MySQL
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)

app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_DB'] = 'smms_db'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor' #receive data in dictionary format

mysql = MySQL(app)

@app.route('/')
def index():
    
    return render_template('index.html')



@app.route('/get_posts', methods =['GET','POST'])
def show_posts():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM posts")
    results = cur.fetchall()
    print(results)
    posts = []
    for i in range(len(results)):
        posts.append(results[i]['Content'])

    return str(posts)
    cur.close()
    # return len(results)

if __name__ == "__main__":
    app.run(debug=True)