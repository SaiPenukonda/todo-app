from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer(), primary_key=True)
    username = db.Column(db.String(), unique=True)
    first_name = db.Column(db.String())
    last_name = db.Column(db.String())
    password = db.Column(db.String())
    emailaddress = db.Column(db.String())

    def __init__(self , username, first_name, last_name, password, emailaddress):
        self.username = username
        self.first_name = first_name
        self.last_name = last_name
        self.password = password
        self.emailaddress = emailaddress

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'id' : self.id,
            'username' : self.username,
            'first_name' : self.first_name,
            'last_name' : self.last_name,
            'password' : self.password,
            'emailaddress' : self.emailaddress
        }