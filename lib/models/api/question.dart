class Question {

  String subject;
  String message;

  int senderId;
  
  DateTime createdAt;

  Question({this.subject, this.message, this.createdAt, this.senderId});

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
      senderId: json['sender_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

}