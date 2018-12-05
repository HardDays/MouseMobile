class FeedbackType {
  static const String bug = 'bug';
  static const String enhancement = 'enhancement';
  static const String compliment = 'compliment';
}

class Feedback {

  String feedbackType;

  String message;

  int score;

  Feedback({this.feedbackType, this.message, this.score=0});

  Map <String, dynamic> toJson(){
    return {
      'feedback_type': feedbackType,
      'message': message,
      'rate_score': score,
    };
  }

}