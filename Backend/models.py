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
    api_key = db.Column(db.String())

    def __init__(self , api_key, username, first_name, last_name, password, emailaddress):
        self.api_key = api_key
        self.username = username
        self.first_name = first_name
        self.last_name = last_name
        self.password = password
        self.emailaddress = emailaddress

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'api_key' : self.api_key,
            'id' : self.id,
            'username' : self.username,
            'first_name' : self.first_name,
            'last_name' : self.last_name,
            'password' : self.password,
            'emailaddress' : self.emailaddress
        }

class Task(db.Model):
    __tablename__ = 'tasks'

    id = db.Column(db.Integer(), primary_key=True)
    title = db.Column(db.String())
    user_id = db.Column(db.Integer(), db.ForeignKey('users.id'))
    note = db.Column(db.String())
    completed = db.Column(db.Boolean(), default=False, nullable=False)
    repeats = db.Column(db.String())
    deadline = db.Column(db.String())
    reminder = db.Column(db.String())

    def __init__(self , title, user_id, note, completed, repeats, deadline, reminder):
        self.title = title
        self.user_id = user_id
        self.note = note
        self.completed = completed
        self.repeats = repeats
        self.deadline = deadline
        self.reminder = reminder

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'title' : self.title,
            'user_id' : self.user_id,
            'id' : self.id,
            'note' : self.note,
            'completed' : self.completed,
            'repeats' : self.repeats,
            'deadline' : self.deadline,
            'reminder' : self.reminder
        }