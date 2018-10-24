enum UserError { ok, emailTaken }

class User {

  UserError error = UserError.ok;

  int id;

  String email;
  String password;
  String passwordConfirmation;
  String token;

  User({this.id, this.error, this.email, this.password, this.passwordConfirmation, this.token});
  
   Map <String, dynamic> toJson(){
    return {
      'id': id,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'token': token
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      token: json['token'],
      error: UserError.ok
    );
  }

}