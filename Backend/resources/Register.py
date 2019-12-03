from flask_restful import Resource
from flask import request
from models import db, User

class Register(Resource):
    def get(self):
        users = User.query.all()
        user_list = []
        for i in range(0, len(users)):
            user_list.append(users[i].serialize())
        return{"status": str(user_list)}, 200

    def post(self):
        json_data = request.get_json(force=True)

        if not json_data:
            return {'message': 'No input data provided'}, 400

        user = User.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message': 'Username already exists'}, 400
        
        user = User.query.filter_by(emailaddress=json_data['emailaddress']).first()
        if user:
            return {'message': 'Email address already exists'}, 400

        user = User(
            emailaddress = json_data['emailaddress'],
            first_name = json_data['first_name'],
            last_name = json_data['last_name'],
            username = json_data['username'],
            password = json_data['password']
        )

        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)

        return {"status": 'success', 'data': result}, 201
