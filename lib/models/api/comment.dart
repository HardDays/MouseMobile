import 'account.dart';

class Comment {

  int id;

  int eventId;
  int fanId;

  String text;

  Account account;
 
  Comment({this.id, this.eventId, this.fanId, this.text, this.account}){
    account.id = fanId;
  }

  Map <String, dynamic> toJson(){
    return {
      'event_id': eventId,
      'text': text,
    };
  } 

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      eventId: json['event_id'],
      fanId: json['fan_id'],
      text: json['text'],
      account: Account.fromJson(json['account'])
    );
  }
}