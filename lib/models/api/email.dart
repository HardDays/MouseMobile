class Email {

  String name;
  String email;

  Email({this.name, this.email});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      email: json['email'],
      name: json['name'],
    );
  }
}