from flask_restful import Resource

class User(Resource):
    __tablename__ = 'users'
    _table_args__ = tuple(db.UniqueConstraint('id', 'username', name='my_2uniq'))

    id = db.Column(db.Integer(), primary_key=True, unique=True)
    username = db.Column(db.String(), primary_key=True)
    firstname = db.Column(db.String())
    lastname = db.Column(db.String())
    password = db.Column(db.String())
    emailaddress = db.Column(db.String())

    def __init__(self , id, api_key, username, firstname, lastname, password, emailaddress):
        self.id = id
        self.api_key = api_key = api_key
        self.username = username
        self.first_name = firstname
        self.last_name = lastname
        self.password = password
        self.emailaddress = emailaddress

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'id' : self.id,
            'api_key' : self.api_key,
            'username' : self.username,
            'first_name' : self.firstname,
            'last_name' : self.lastname,
            'password' : self.password,
            'emailaddress' : self.emailaddress
        }

    def get(self):
        return {"message": "Hello, World!"}