from flask import Flask, render_template, flash, session, redirect, url_for
from sqlalchemy import select, delete, desc, update, and_
from werkzeug.security import generate_password_hash, check_password_hash

from models.forms import LoginForm, RegisterForm, CreateForm
from models.database import db, Recipes, Users


app = Flask(__name__)
app.secret_key = "super_secret_key"

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:super_secret_password@localhost/flask'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ENGINE_OPTIONS'] = {
    "pool_pre_ping": True,
    'pool_recycle' : 280}

db.init_app(app)

with app.app_context():
    db.create_all()

chyba = "Něco se pokazilo, kontaktujte administrátora."

@app.route("/")
def index():
    recipes = []

    try:
        stmt = select(Recipes).order_by(desc(Recipes.created))
        recipes = db.session.execute(stmt).scalars().all()
    except:
        flash(chyba, "danger")

    return render_template("index.html", recipes=recipes)

@app.route("/register", methods=["GET", "POST"])
def register():
    registerform = RegisterForm()

    if registerform.validate_on_submit():
        try:
            stmt = select(Users.username).where(Users.username == registerform.username.data)
            if db.session.execute(stmt).scalar_one_or_none() is not None:
                flash("Jméno je již zabrané", "warning")
                return render_template("register.html", registerform=registerform)
            
            if registerform.password_one.data != registerform.password_two.data:
                flash("Hesla se neshodují.", "warning")
                return render_template("register.html", registerform=registerform)

            new_user = Users()
            new_user.username = registerform.username.data
            new_user.password = generate_password_hash(registerform.password_one.data)
            
            db.session.add(new_user)
            db.session.commit()
            
            flash("Úspěšná registrace.", "success")
        except:
            flash(chyba, "danger")

    return render_template("register.html", registerform=registerform)

@app.route("/login", methods=["GET", "POST"])
def login():
    loginform = LoginForm()
    if loginform.validate_on_submit():
        try:
            stmt = select(Users).where(Users.username == loginform.username.data)
            user = db.session.execute(stmt).scalar_one_or_none()

            if user is None:
                flash("Uživatel neexistuje.", "warning")
                return render_template("login.html", loginform=loginform)
            
            if user.authorized is False:
                flash("Neautorizovaný uživatel.", "warning")
                return render_template("login.html", loginform=loginform)

            if check_password_hash(user.password, loginform.password.data):
                session["user"] = user.id
                session["role"] = user.role
                return index()
            else:
                flash("Nesprávné heslo.", "warning")
                return render_template("login.html", loginform=loginform)
        except:
            flash(chyba, "danger")

    return render_template("login.html", loginform=loginform)

@app.route("/logout", methods=["GET"])
def logout():
    del session["user"]
    del session["role"]
    flash("Odhlášení proběhlo úspěšně.", "success")

    return index()

@app.route("/create_recipe", methods=["GET", "POST"])
def create_recipe():
    createform = CreateForm()

    if createform.validate_on_submit() and session["user"]:
        try:
            new_recipe = Recipes()
            new_recipe.name = createform.name.data
            new_recipe.text = createform.text.data
            new_recipe.creator_id = session["user"]

            db.session.add(new_recipe)
            db.session.commit()

            flash("Recept úspěšně vytvořen", "success")

            return render_template("create_recipe.html", createform = CreateForm())
        except:
            flash(chyba, "danger")
            
    return render_template("create_recipe.html", createform = createform)

@app.route("/myrecipes")
def myrecipes():
    recipes = []

    try:
        if session["user"]:
            stmt = select(Users).where(Users.id == session["user"])
            user = db.session.execute(stmt).scalar_one_or_none()

            if user is None:
                flash("Neznámý uživatel", "warning")
                return redirect(url_for("index"))

            if not user.authorized:
                flash("Uživatel nebyl autorizován", "warning")
                return redirect(url_for("index"))

            recipes = user.recipes
        else:
            flash("Neznámý uživatel", "warning")
            return redirect(url_for("index"))
    except:
        flash(chyba, "danger")

    return render_template("myrecipes.html", recipes=recipes)

@app.route("/delete_recipe/<recipe_id>")
def delete_recipe(recipe_id):
    if session["user"]:
        try:
            if session["role"] == "admin":
                stmt = select(Recipes).where(Recipes.id == recipe_id)
            else:
                stmt = select(Recipes).where(and_(Recipes.id == recipe_id, Recipes.creator_id == session["user"]))

            if db.session.execute(stmt).scalar_one_or_none() is None:
                flash("Neexistující příspěvek nebo uživatel", "danger")
            else:
                stmt = delete(Recipes).where(Recipes.id == recipe_id)

                db.session.execute(stmt)
                db.session.commit()

                flash("Recept byl úspěšně smazán", "success")
        except:
            flash(chyba, "danger")
    else:
        flash("Neznámý uživatel", "warning")
        return redirect(url_for("index"))
    
    return myrecipes()

@app.route("/about")
def about():
    return render_template("about.html")

@app.route("/users")
def users():
    users = []

    if session["user"] and session["role"] == "admin":
        try:
            stmt = select(Users.id, Users.username, Users.role, Users.authorized)
            users = db.session.execute(stmt).all()
        except:
            flash(chyba, "danger")
    else:
        flash("Neznámý uživatel", "warning")
        return redirect(url_for("index"))
    
    return render_template("users.html", users=users)

@app.route("/authorize/<user_id>")
def authorize(user_id):
    try:
        stmt = select(Users.authorized).where(Users.id == user_id)
        user = db.session.execute(stmt).scalar_one_or_none()

        if user is None:
            flash("Uživatel neexistuje", "danger")
        
        if user:
            stmt = update(Users).where(Users.id == user_id).values(authorized=False)
        else:
            stmt = update(Users).where(Users.id == user_id).values(authorized=True)

        db.session.execute(stmt)
        db.session.commit()
    except:
        flash(chyba, "danger")

    return users()

@app.route("/delete_user/<user_id>")
def delete_user(user_id):
    try:
        stmt = select(Users.authorized).where(Users.id == user_id)
        user = db.session.execute(stmt).scalar_one_or_none()

        if user is None:
            flash("Uživatel neexistuje", "danger")
        
        stmt = delete(Users).where(Users.id == user_id)
        db.session.execute(stmt)
        db.session.commit()
    except:
        flash(chyba, "danger")
    return users()