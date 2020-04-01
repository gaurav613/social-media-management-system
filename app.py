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

# function to display all posts made
@app.route('/get_posts', methods =['GET','POST'])
def show_posts():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM posts")
    results = cur.fetchall()
    # print(results)
    # posts = []
    # for i in range(len(results)):
    #     posts.append(results[i]['Content'])
    cur.close()
    return render_template('post_history.html',posts=results)
    # return len(results)

# move to the login page
@app.route('/login_page', methods=['POST'])
def login_page():
    return render_template('login.html')

# move to the signup page
@app.route('/signup_page', methods=['POST'])
def signup_page():
    return render_template('signup.html')

# function to sign up
@app.route('/signup', methods =['GET','POST'])
def sign_up():
    username = str(request.form["username"])
    password = str(request.form["password"])
    email = str(request.form["email"])
    employeeid = str(request.form["employeeid"])

    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO users (username,password,email,EmployeeID) VALUES (%s,%s,%s,%s)",(username,password,email,employeeid))
    mysql.connection.commit()
    cursor.close()
    return render_template('login.html')

# function to log in
@app.route('/login',methods=['GET','POST'])
def log_in():
    username = str(request.form["username"])
    password = str(request.form["password"])

    cursor = mysql.connection.cursor()
    cursor.execute("SELECT username FROM users WHERE username = '"+username+"';")
    user = cursor.fetchone()
    if user is None:
        return 'Login Failed'
    else:
        return redirect('/')

    mysql.connection.commit()
    cursor.close()

@app.route('/main_page', methods =['GET','POST'])
def return_to_page():
    return redirect('/')

if __name__ == "__main__":
    app.run(debug=True)