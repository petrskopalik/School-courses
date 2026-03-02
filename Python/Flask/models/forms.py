from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, TextAreaField
from wtforms.validators import DataRequired, InputRequired, Length


class RegisterForm(FlaskForm):
    username = StringField("username", validators=[DataRequired(), InputRequired(), Length(1, 30)])
    password_one = PasswordField("password_one", validators=[DataRequired(), InputRequired(), Length(1, 30)])
    password_two = PasswordField("password_two", validators=[DataRequired(), InputRequired(), Length(1, 30)])
    submit = SubmitField("Registrovat")

class LoginForm(FlaskForm):
    username = StringField("username", validators=[DataRequired(), InputRequired(), Length(1, 30)])
    password = PasswordField("password", validators=[DataRequired(), InputRequired(), Length(1, 30)])
    submit = SubmitField("Přihlásit")

class CreateForm(FlaskForm):
    name = StringField("name", validators=[DataRequired(), InputRequired(), Length(1, 30)])
    text = TextAreaField("text", validators=[DataRequired(), InputRequired(), Length(1, 10000)])
    submit = SubmitField("Odeslat")