class Question {

  String subject;
  String message;
  
  DateTime createdAt;

  Question({this.subject, this.message, this.createdAt});

  Map <String, dynamic> toJson(){
    return {
      'subject': subject,
      'message': message,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      subject: json['subject'],
      message: json['message'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

}