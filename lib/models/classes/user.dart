


class User {
  String username;
  String lastname;
  String firstname;
  String email;
  String password;
  String api_Key;
  int id;

  User(this.username, this.lastname, this.firstname, this.email, this.password, this.api_Key);

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User (
      parsedJson['username'],
      parsedJson['lastname'],
      parsedJson['emailaddress'],
      parsedJson['firstname'],
      parsedJson['password'],
      parsedJson['api_Key']
    );
  }
}