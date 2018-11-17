
class User {


  int id;

  String email;
  String password;
  String oldPassword;
  String passwordConfirmation;
  String token;
  String registerPhone;

  User({this.id, this.email, this.password, this.oldPassword, this.passwordConfirmation, this.token, this.registerPhone});
  
   Map <String, dynamic> toJson(){
    return {
      'id': id,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'token': token,
      'register_phone': registerPhone,
      'old_password': oldPassword
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      token: json['token'],
      registerPhone: json['register_phone']
    );
  }

}