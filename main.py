from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from flask_mail import Mail
import json



# MY db connection
local_server= True
app = Flask(__name__)
app.secret_key='shahdanish'


# this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'

# SMTP MAIL SERVER SETTINGS

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME="add your gmail-id",
    MAIL_PASSWORD="add your gmail-password"
)
mail = Mail(app)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))




# app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/ngo'
db=SQLAlchemy(app)



# here we will create db models that is tables

class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    usertype=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Donors(db.Model):
    did=db.Column(db.Integer,primary_key=True)
    bank=db.Column(db.String(50))
    ifsc_code=db.Column(db.String(50))
    account=db.Column(db.Integer)
    amount=db.Column(db.Integer)

class Items(db.Model):
    iid=db.Column(db.Integer,primary_key=True)
    item_name=db.Column(db.String(50))
    quantity=db.Column(db.String(50))
    pickup_adrs=db.Column(db.String(50))
    phone_no=db.Column(db.String(50))
    donation_date=db.Column(db.String(50))

class Volunteer(db.Model):
    vid=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(50))
    email=db.Column(db.String(50))
    phone_no=db.Column(db.String(50))
    age=db.Column(db.Integer)
    occupation=db.Column(db.String(50))
    doj=db.Column(db.String(50))

class Tasks(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    task_description=db.Column(db.String(150))
    task_leader=db.Column(db.String(50))
    task_assigned_on=db.Column(db.String(50))

# here we will pass endpoints and run the fuction
@app.route('/')
def index():
    return render_template('index.html')
    


@app.route('/donors',methods=['POST','GET'])
def donors():

    if request.method=="POST":

        bank=request.form.get('bank')
        ifsc_code=request.form.get('ifsc_code')
        account=request.form.get('account')
        amount=request.form.get('amount')

        query=db.engine.execute(f"INSERT INTO `donors` (`bank`,`ifsc_code`,`account`,`amount`) VALUES ('{bank}','{ifsc_code}','{account}', '{amount}')")
        flash("Information is Stored","primary")

    return render_template('donor.html')

@app.route('/items',methods=['POST','GET'])
def items():

    if request.method=="POST":

        item_name=request.form.get('item_name')
        quantity=request.form.get('quantity')
        pickup_adrs=request.form.get('pickup_adrs')
        phone_no=request.form.get('phone_no')
        donation_date=request.form.get('donation_date')

        query=db.engine.execute(f"INSERT INTO `items` (`item_name`,`quantity`,`pickup_adrs`,`phone_no`, `donation_date`) VALUES ('{item_name}','{quantity}','{pickup_adrs}', '{phone_no}', '{donation_date}')")
        flash("Information is Stored","primary")

    return render_template('items.html')


@app.route('/volunteer',methods=['POST','GET'])
def volunteer():

    if request.method=="POST":

        name=request.form.get('name')
        email=request.form.get('email')
        phone_no=request.form.get('phone_no')
        age=request.form.get('age')
        occupation=request.form.get('occupation')
        doj=request.form.get('doj')

        query=db.engine.execute(f"INSERT INTO `volunteer` (`name`,`email`,`phone_no`,`age`,`occupation`,`doj`) VALUES ('{name}','{email}','{phone_no}', '{age}', '{occupation}', '{doj}')")
        flash("Information is Stored","primary")

    return render_template('volunteer.html')
    

@app.route('/volunteerinfo')
@login_required
def volunteerinfo(): 
    em=current_user.email
    if current_user.usertype=="Volunteer":
        query=db.engine.execute(f"SELECT * FROM `volunteer`")
        return render_template('volunteerbuds.html',query=query)
    else:
        query=db.engine.execute(f"SELECT * FROM `volunteer` WHERE email='{em}'")
        return render_template('volunteerbuds.html',query=query)
    


@app.route("/delete/<string:tid>",methods=['POST','GET'])
@login_required
def delete(tid):
    db.engine.execute(f"DELETE FROM `tasks` WHERE `tasks`.`tid`={tid}")
    flash("Slot Deleted Successful","danger")
    return redirect('/volunteerinfo')

@app.route('/signup',methods=['POST','GET'])
def signup():
    if request.method == "POST":
        username=request.form.get('username')
        usertype=request.form.get('usertype')
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()
        if user:
            flash("Email Already Exist","warning")
            return render_template('/signup.html')
        encpassword=generate_password_hash(password)

        new_user=db.engine.execute(f"INSERT INTO `user` (`username`,`usertype`,`email`,`password`) VALUES ('{username}','{usertype}','{email}','{encpassword}')")

        # this is method 2 to save data in db
        # newuser=User(username=username,email=email,password=encpassword)
        # db.session.add(newuser)
        # db.session.commit()
        flash("Signup Success Please Login","success")
        return render_template('login.html')

    return render_template('signup.html')

@app.route('/tasks')
@login_required
def tasks():
    # posts=Trigr.query.all()
    posts=db.engine.execute("SELECT * FROM `tasks`")
    return render_template('tasks.html',posts=posts)


@app.route("/edit/<string:tid>",methods=['POST','GET'])
@login_required
def edit(tid):
    posts=Tasks.query.filter_by(tid=tid).first()
    if request.method=="POST":
        task_description=request.form.get('task_description')
        task_leader=request.form.get('task_leader')
        task_assigned_on=request.form.get('task_assigned_on')
        db.engine.execute(f"UPDATE `tasks` SET `task_description` = '{task_description}', `task_leader` = '{task_leader}', `task_assigned_on` = '{task_assigned_on}' WHERE `tasks`.`tid` = {tid}")
        flash("Task is Updated","success")
        return redirect('/tasks')
    
    return render_template('edit.html',posts=posts)


@app.route('/login',methods=['POST','GET'])
def login():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password,password):
            login_user(user)
            flash("Login Success","primary")
            return redirect(url_for('index'))
        else:
            flash("invalid credentials")
            return render_template('login.html')    

    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logout SuccessFul","warning")
    return redirect(url_for('login'))
    

@app.route('/itemdetails')
@login_required
def itemdetails():
    # posts=Trigr.query.all()
    posts=db.engine.execute("SELECT * FROM `items`")
    return render_template('itemdonations.html',posts=posts)

@app.route('/about')
def about():
    return render_template('about.html')
    
app.run(debug=True)    

