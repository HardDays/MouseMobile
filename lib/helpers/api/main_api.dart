import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/api/user.dart';
import '../../models/api/account.dart';
import '../../models/api/event.dart';
import '../../models/api/comment.dart';

import '../../helpers/storage/filters/shows_filter.dart';

class MainAPI {
  //static const String url = 'https://protected-island-7029.herokuapp.com/';
  
  static const String url = 'https://mouse-back.herokuapp.com';

  static const String auth = '/auth';
  static const String vk = '/vk';
  static const String fb = '/facebook';
  static const String users = '/users';
  static const String accounts = '/accounts';
  static const String login = '/login';
  static const String me = '/me';
  static const String my = '/my';
  static const String images = '/images';
  static const String full = '/full';
  static const String events = '/events';
  static const String search = '/search';
  static const String preview = '/preview';
  static const String comments = '/comments';
  static const String upcomingShowws = '/upcoming_shows';
  static const String followers = '/followers';
  static const String following = '/following';

  static String token;

  static Map <String, String> defaultHeader = {
    'Content-type' : 'application/json', 
  };

  static void updateToken(String tk){
    token = tk;
    defaultHeader = {
      'Content-type' : 'application/json', 
      'Authorization': token
    };
  }
  
  static Future<http.Response> basePostRequest(String method, String body) async {
    return await http.post(url + method, body: body, headers: defaultHeader);
  }

  static Future<http.Response> baseGetRequest(String method, Map<String, dynamic> params) async {
    var queryParams = '';
    if (params.isNotEmpty){
      queryParams = '?';

      for (var param in params.keys){
        var val = params[param];
        if (val != null){
          if (val is List<String>){
            for (var arr in val){
              queryParams += '$param%5B%5D=$arr';
            }
          } else {
            queryParams += '$param=$val&';
          }
        }
      }
    }
    return await http.get(url + method + queryParams, headers: defaultHeader);
  }

  // AUTH

  static Future<String> authorize(String userName, String password) async {
    var res = await http.post(url + auth + login, 
      body: json.encode({
        'user_name': userName,
        'email': userName,
        'password': password
      }),
      headers: {
        'Content-type' : 'application/json', 
      }
    );
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
     return json.decode(res.body)['token'];
   } 
 }

  // USERS

  static Future<User> getMe() async {
    var res = await http.get(url + users + me,
      headers: defaultHeader
    );
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      return User.fromJson(json.decode(res.body));
    } 
  }

  static Future<User> createUser(User user) async {
    var res = await http.post(url + users, 
      body: json.encode(user.toJson()),
      headers: {
        'Content-type' : 'application/json', 
      }
    );
    //TODO: better error check
    if (res.statusCode == HttpStatus.created){
      return User.fromJson(json.decode(res.body));
    } else {
      return User(error: UserError.emailTaken);
    }
  }

  // ACCOUNTS

  static Future<Account> getMyAccount() async {
    var res = await http.get(url + accounts + my,
      headers: defaultHeader
    );
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      List body = json.decode(res.body);
      var list = body.map<Account>((x) => Account.fromJson(x)).toList();
      if (list.isNotEmpty){
        return list[0];
      }
    } 
  }

  static Future<Account> getAccount(int id) async {
    var res = await baseGetRequest(accounts + '/$id', {'extended': true});
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      return Account.fromJson(json.decode(res.body));
    }
  }

  static Future<List<Account>> getFollowers(int id) async {
    var res = await baseGetRequest(accounts + '/$id' + followers, {'extended': true});
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      var body = json.decode(res.body);
      return body['followers'].map<Account>((x) => Account.fromJson(x)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Account>> getFollowing(int id) async {
    var res = await baseGetRequest(accounts + '/$id' + following, {'extended': true});
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      var body = json.decode(res.body);
      return body['following'].map<Account>((x) => Account.fromJson(x)).toList();
    } else {
      return [];
    }
  }

  static Future<Account> createAccount(Account user) async {
    var res = await http.post(url + accounts, 
      body: json.encode(user.toAPIJson()),
      headers: defaultHeader
    );
    //TODO: better error check
    if (res.statusCode == HttpStatus.created){
      return Account.fromJson(json.decode(res.body));
    } else {
      return Account(error: AccountError.userNameTaken);
    }
  }

  static Future<Account> updateAccount(Account user) async {
    var res = await http.patch(url + accounts + '/${user.id}', 
      body: json.encode(user.toAPIJson()),
      headers: defaultHeader
    );
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      return Account.fromJson(json.decode(res.body));
    } else {
      return Account(error: AccountError.userNameTaken);
    }
  }

  static Future<List<Account>> searchAccounts({String text, String accountType, int limit, int offset}) async {
    Map <String, dynamic> params = {
      'text': text, 
      'type': accountType ?? AccountType.fan,
      'limit': limit,
      'offset': offset
    };
    var res = await baseGetRequest(accounts + search, params);
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      List body = json.decode(res.body);
      return body.map<Account>((x) => Account.fromJson(x)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Event>> getUpcomingShows(int id, {int limit, int offset}) async {
    Map <String, dynamic> params = {
      'limit': limit,
      'offset': offset
    };
    var res = await baseGetRequest(accounts + '/$id' + upcomingShowws, params);
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      List body = json.decode(res.body);
      var list = body.map<Event>((x) => Event.fromJson(x)).toList();
      return list;
    } else {
      return [];
    }
  }

  //EVENTS

  static Future<List<Event>> searchEvents({String text, ShowsFilter filter}) async {
    Map<String, dynamic> params = {
      'mobile':'true',
      'text': text
    };
    if (filter != null){
      params.addAll(filter.toJson());
    }
  
    var res = await baseGetRequest(events + search, params);
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      List body = json.decode(res.body);
      return body.map<Event>((x) => Event.fromJson(x)).toList();
    } else {
      return [];
    }
  }

  static Future<Event> getEvent(int id) async {
    var res = await baseGetRequest(events + '/$id', {});
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      return Event.fromJson(json.decode(res.body));
    }
  }

   static Future<List<Comment>> getEventComments(int id) async {
    var res = await baseGetRequest(events + '/$id' + comments, {});
    //TODO: better error check
    if (res.statusCode == HttpStatus.ok){
      List body = json.decode(res.body);
      return  body.map<Comment>((x) => Comment.fromJson(x)).toList();
    } else {
      return [];
    }
  }

  // IMAGES

  static String getImageUrl(int imageId){
    return url + images + '/$imageId' + preview + '?width=1024&height=768';
  }

  static String getAccountImageUrl(int imageId){
    return url + images + '/$imageId' + preview + '?width=512&height=384';
  }



}