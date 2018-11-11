import 'account.dart';
import 'event.dart';
import 'video.dart';

class FeedType {
  static const String eventUpdate = 'event_update';
  static const String accountUpdate = 'account_update';
}


class FeedField {
  static const String video = 'video';
  static const String image = 'image';
  static const String album = 'album';
  static const String audio = 'audio';
  static const String description = 'description';
  static const String address = 'address';
  static const String phone = 'phone';
  static const String about = 'about';
  static const String userName = 'user_name';
  static const String displayName = 'display_name';
  static const String stageName = 'stage_name';
  static const String genre = 'genre';  
}


class FeedAction {
  static const String launchEvent = 'launch_event';
  static const String addTicket = 'add_ticket';
  static const String addVideo = 'add_video';
  static const String addImage = 'add_image';
  static const String update = 'update';
  static const String addGenre = 'add_genre';
  static const String addArtist = 'add_artist';
}

class FeedItem {

  int id;

  String action;
  String field;
  String type;
  String value;

  DateTime createdAt;

  Account account;
  Event event;
  Video video;

  int likesCount;
  int commentsCount;

  bool isDeleted;
  bool isLiked;

  FeedItem({this.id, this.action, this.field, this.value, this.type, this.account, this.event, this.video,
            this.createdAt, this.likesCount, this.commentsCount, this.isDeleted, this.isLiked});

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id'],
      action: json['true_action'],
      field: json['field'],
      type: json['type'],
      value: json['value'],
      likesCount: json['likes'] ?? 0,
      commentsCount: json['comments'] ?? 0,
      isDeleted: json['deleted'] ?? false,
      isLiked: json['liked'] ?? false,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      account: json['account'] != null ? Account.fromJson(json['account']) : null,
      event: json['event'] != null ? Event.fromJson(json['event']) : null,
      video: json['video'] != null ? Video.fromJson(json['video']) : null,
    );
  }

}