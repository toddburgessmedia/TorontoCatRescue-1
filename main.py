import os
from flask import Flask, session, render_template, redirect, url_for,request
from flask_dance.consumer import oauth_authorized
from flask_dance.contrib.google import make_google_blueprint, google
from werkzeug.utils import secure_filename
from flask_wtf import CsrfProtect
from form_classes import CatInformation
from google_sheets import find_permission, input_data, return_database
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session as dbsession
from sqlalchemy import create_engine

import config

#connect to mariadb
Base = automap_base()
engine = create_engine("mysql+pymysql://root:root@localhost/torontocatrescue")
Base.prepare(engine, reflect=True)

CSRF = CsrfProtect()

# Don't warn when Google changes scope on us
os.environ["OAUTHLIB_RELAX_TOKEN_SCOPE"] = "1"

GOOGLE_CLIENT_ID = config.OAUTH_CONFIG['GOOGLE_CLIENT_ID']
GOOGLE_CLIENT_SECRET = config.OAUTH_CONFIG['GOOGLE_CLIENT_SECRET']
STATIC_URL_PATH = '/static'
APP = Flask(__name__, static_url_path=STATIC_URL_PATH)
APP.config['SECRET_KEY'] = 'cats'

GOOGLE_BP = make_google_blueprint(
    client_id=GOOGLE_CLIENT_ID,
    client_secret=GOOGLE_CLIENT_SECRET,
    scope=["https://www.googleapis.com/auth/userinfo.email"],
    authorized_url='/oauth2callback'
)
APP.register_blueprint(GOOGLE_BP)


@oauth_authorized.connect_via(GOOGLE_BP)
def logged_in(blueprint, token):
    respon_json = google.get('/oauth2/v2/userinfo').json()
    print(respon_json)
    session['access_token'] = token
    session['email'] = respon_json['email']


@APP.route('/shelter_upload', methods=['GET', 'POST'])
def shelter_upload():
    if 'username' not in session:
        return redirect('/login')

    form = CatInformation()
    if form.validate_on_submit():
        input_data(form, 'shelter')

        if form.photo.data is not None:
            pho = form.photo.data
            filename = secure_filename(pho.filename)
            pho.save(os.path.join(APP.instance_path, 'photos', filename))

        if form.medical_documents.data is not None:
            med_docs = form.medical_documents.data
            filename = secure_filename(med_docs.filename)
            med_docs.save(os.path.join(APP.instance_path,
                                       'medical_documents', filename))

        return redirect(url_for('index'))
    else:
        print(form.errors)

    return render_template('shelter_upload.html', form=form, title="new")


@APP.route('/intake_upload', methods=['GET', 'POST'])
def intake_upload():
    if 'username' not in session:
        return redirect('/login')

    form = CatInformation()
    if form.validate_on_submit():
        input_data(form, 'intake')

        if form.photo.data is not None:
            pho = form.photo.data
            filename = secure_filename(pho.filename)
            pho.save(os.path.join(APP.instance_path, 'photos', filename))

        if form.medical_documents.data is not None:
            med_docs = form.medical_documents.data
            filename = secure_filename(med_docs.filename)
            med_docs.save(os.path.join(APP.instance_path,
                                       'medical_documents', filename))

        return redirect(url_for('index'))
    else:
        print(form.errors)

    return render_template('intake_upload.html', form=form)


@APP.route('/foster_upload', methods=['GET', 'POST'])
def foster_upload():
    if 'username' not in session:
        return redirect('/login')

    form = CatInformation()
    if form.validate_on_submit():
        input_data(form, 'foster')

        if form.photo.data is not None:
            pho = form.photo.data
            filename = secure_filename(pho.filename)
            pho.save(os.path.join(APP.instance_path, 'photos', filename))

        if form.medical_documents.data is not None:
            med_docs = form.medical_documents.data
            filename = secure_filename(med_docs.filename)
            med_docs.save(os.path.join(APP.instance_path,
                                       'medical_documents', filename))

        return redirect(url_for('index'))
    else:
        print(form.errors)
    return render_template('foster_upload.html', form=form, title="new")


@APP.route('/database')
def database():
    if 'username' not in session:
        return redirect('/login')

    card = return_database()
    card.pop(0)
    return render_template('database.html', cards=card, title="data")


@APP.route('/waitlist')
def waitlist():
    if 'username' not in session:
        return redirect('/login')

    card = return_database()
    card = [i for i in card if i[20] == "shelter"]
    return render_template('database.html', cards=card, title="wait")

@APP.route('/login', methods=['POST'])
def post_login():
	username = request.form['username']
	password = request.form['password']
	print("Login: {} {}".format(username,password))
	if username != None and password != None:
		print("trying to log in.....")
		userlogin = Base.classes.UserLogin
		db_session = dbsession(engine)
		result = db_session.query(userlogin) \
			.filter(userlogin.UserName==username, \
			userlogin.Password==password)
		if result.first() == None:
			print("We failed")
			return render_template('login.html',fail='True',login="true") 
		else:
			print("We did it")
			print("Role: {}".format(result.first().UserRole))
			session['username'] = username
			session['role'] = result.first().UserRole
			return redirect(url_for('intake_upload'))
	else:
		return render_template('login.html',fail='True',login="true") 
	
@APP.route('/login', methods=['GET'])
def get_login():
	return render_template('login.html',login='true') 

@APP.route('/')
def index():
    if 'username' not in session:
        return redirect('/login')

    email = session.get('email')
    permission = session.get('role') 
    print(permission)
    print(email)

    if permission == 'shelter':
        return redirect(url_for('shelter_upload'))
    elif permission == 'intake' or permission == 'admin':
        return redirect(url_for('intake_upload'))
    elif permission == 'fostercoordinator':
        return redirect(url_for('foster_upload'))
    else:
        return "User not in system"

    # form = LoginForm()
    # return render_template('index.html', title='Sign In', form=form)


if __name__ == '__main__':
    os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"
    APP.jinja_env.auto_reload = True
    APP.run(debug=True)
