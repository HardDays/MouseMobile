
class User {


  int id;

  String email;
  String password;
  String oldPassword;
  String passwordConfirmation;
  String token;
  String registerPhone;

  User({this.id, this.email, this.password, this.oldPassword, this.passwordConfirmation, this.token, this.registerPhone});
  
  void field(Map <String, dynamic> res, String name, String field){
    if (field != null){
      res[name] = field;
    }
  }

  Map <String, dynamic> toJson(){
    Map <String, dynamic> res = {
      'id': id,
      'token': token,
    };
    field(res, 'email', email);
    field(res, 'password', password);
    field(res, 'password_confirmation', passwordConfirmation);
    field(res, 'register_phone', registerPhone);
    field(res, 'old_password', oldPassword);
    return res;
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