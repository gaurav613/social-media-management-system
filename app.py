from flask import Flask, render_template, url_for, request, redirect
from flask_mysqldb import MySQL
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime


# datetime object containing current date and time


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
    cur.execute("SELECT * FROM posts NATURAL JOIN liveposts NATURAL JOIN employees")
    results = cur.fetchall()
    cur.close()
    return render_template('post_history.html',posts=results)
    
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
    cursor.execute("SELECT username,password FROM users WHERE username = '"+username+"';")
    user = cursor.fetchone()
    if user is None:
        return render_template('failure_page.html',message='User not found! Please try again')
    elif(user['password']!=password):
        return render_template('failure_page.html',message='Wrong password! Please try again')
    else:
        return redirect('/userPage/'+username)
    mysql.connection.commit()
    cursor.close()

# employee page
@app.route('/userPage/<string:username>',methods = ['GET','POST'])
def userPage(username):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT EmployeeID, Name, isApprover FROM users NATURAL JOIN employees WHERE username = '"+username+"';")
    emp = cursor.fetchone()
    eid = str(emp['EmployeeID'])
    name = str(emp['Name'])
    isApprover = str(emp['isApprover'])
    cursor.execute("SELECT postID,Content,Status,EmployeeID FROM employees NATURAL JOIN liveposts NATURAL JOIN posts WHERE EmployeeID = "+eid+";")
    posts = cursor.fetchall()

    if(isApprover=='1'):
        cursor.execute("SELECT Content,Name,postID FROM posts NATURAL JOIN liveposts NATURAL JOIN employees WHERE approved=0")
        unapproved_posts = cursor.fetchall()
        return render_template('approver_page.html',user=name,posts=posts,empID=eid,unapproved_posts=unapproved_posts)
    else:
        return render_template('employee_page.html',user=name,posts=posts,empID=eid)
    cursor.close()


# make a post
@app.route('/submitPost',methods = ['GET','POST'])
def submitPost():
    cursor = mysql.connection.cursor()
    EmployeeID = str(request.form['empID'])
    postContent = str(request.form['postContent'])
    
    cursor.execute("INSERT INTO posts (IsScheduled, Content, Status, approved) VALUES (0,'"+postContent+"','Draft',0);")
    mysql.connection.commit()
    now = datetime.now()
 
    # print("now =", now)

    # dd/mm/YY H:M:S
    dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
    
    cursor.execute("SELECT PostID from posts WHERE Content='"+postContent+"';")
    postID = str(cursor.fetchone()['PostID'])
    cursor.execute("INSERT INTO liveposts (SiteURL, PostID, EmployeeID, PostUploadTime) VALUES ('twitter.com',(%s),(%s),(%s))",(postID,EmployeeID,dt_string))
    mysql.connection.commit()
    

    cursor.execute("SELECT username FROM users WHERE EmployeeID="+EmployeeID)
    username = str(cursor.fetchone()['username'])
    cursor.close()
    return render_template("post_success.html",username=username)

# function to approve a post
@app.route('/approvePost/<int:postID>/<string:user>',methods =['GET','POST'])
def approvePost(postID,user):
    cursor = mysql.connection.cursor()
    pID = str(postID)
    cursor.execute("UPDATE posts SET approved=1,Status='Live' WHERE PostID="+pID+";")
    mysql.connection.commit()

    cursor.execute("SELECT username FROM users NATURAL JOIN employees WHERE Name='"+user+"';")
    username = str(cursor.fetchone()['username'])
    cursor.close()
    return render_template("approval_success.html",username=username)

# redirect to update screen
@app.route("/update/<int:postID>/<string:user>")
def update(postID,user):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT username from employees Natural Join users WHERE Name='"+user+"';")
    username = cursor.fetchone()['username']
    cursor.close()
    return render_template("update_post.html",postID=postID,user=username)

# update a draft post
@app.route("/updatePost/<int:postID>/<string:user>", methods =['GET','POST'])
def updatePost(postID,user):
    cursor = mysql.connection.cursor()
    updated_content = str(request.form['updatedContent'])
    cursor.execute("UPDATE posts SET Content= '"+updated_content+"' WHERE PostID="+str(postID)+";")
    mysql.connection.commit()
    cursor.close()

    return redirect('/userPage/'+user)

# redirect to main page
@app.route('/main_page', methods =['GET','POST'])
def return_to_page():
    return redirect('/')

if __name__ == "__main__":
    app.run(debug=True)