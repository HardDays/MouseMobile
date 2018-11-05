import 'image.dart';
import 'video.dart';
import 'event.dart';
import 'email.dart';

class AccountType {
  
  static const String fan = 'fan';
  static const String venue = 'venue';
  static const String artist = 'artist';
  
}

enum AccountError { ok, userNameTaken }

class Account {

  AccountError error = AccountError.ok;

  int id;
  int imageid;

  int followersCount;
  int followingCount;

  String userName;
  String firstName;
  String lastName;
  String displayName;
  String about;
  String bio;
  String description;
  String phone;
  String fax;

  String accountType;

  String address;
  String preferredAddress;

  List <String> genres;
  List <Image> images;
  List <Video> videos;
  List <Event> upcomingShows;
  List <Email> emails;

  Account({
      this.error, this.id, this.imageid, this.followersCount, this.followingCount, this.phone, this.fax,
      this.userName, this.firstName, this.displayName, this.lastName, this.about, this.bio, this.description,
      this.address, this.preferredAddress, this.accountType,
      this.genres, this.images, this.videos, this.upcomingShows, this.emails
    }
  ) { 
    if (videos != null){
      videos = videos?.where((v) => v.link.contains('youtu'))?.toList();
    }
  }
  
   Map <String, dynamic> toJson(){
    return {
      'id': id,
      'user_name': userName,
      'first_name': firstName,
      'last_name': lastName,
      'account_type': accountType
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      userName: json['user_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      accountType: json['account_type'],
      displayName: json['display_name'],
      address: json['address'],
      preferredAddress: json['preferred_address'],
      imageid: json['image_id'],
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      about: json['about'],
      bio: json['bio'],
      description: json['description'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      videos: json['videos'] != null ? json['videos'].map<Video>((x) => Video.fromJson(x)).toList() : [],
      images: json['images'] != null ? json['images'].map<Image>((x) => Image.fromJson(x)).toList() : [],
      phone: json['phone'],
      fax: json['fax'],
      upcomingShows: [],
      emails: json['emails'] != null ? json['emails'].map<Email>((x) => Email.fromJson(x)).toList() : [],
      error: AccountError.ok
    );
  }

}