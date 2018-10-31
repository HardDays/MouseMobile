import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import '../../models/api/user.dart';
import '../../models/api/account.dart';

class Database {


  static Map<String, dynamic> _db = {};

  static File _file;

  static Future init() async {
    String path = (await getApplicationDocumentsDirectory()).path;

    _file = File('$path/mousedb.json');
    bool exists = await _file.exists();

    if (exists){
      String body = await _file.readAsString(); 
      try {
        _db = json.decode(body);     
      } catch (Exception){
        _db = Map <String, String>();
        await _file.writeAsString('{}');
      }
    } else {
      await _file.create();
      await _file.writeAsString('{}');
    }
  }

  static User getCurrentUser() {
    if (_db.containsKey('current_user')) {
      return User.fromJson(json.decode(_db['current_user']));
    }
  }

  static void setCurrentUser(User value) {
    _db['current_user'] = json.encode(value.toJson());
    _file.writeAsStringSync(json.encode(_db));
  }

  static void deleteCurrentUser() {
    _db.remove('current_user');
    _file.writeAsStringSync(json.encode(_db));
  }

  static Account getCurrentAccount() {
    if (_db.containsKey('current_account')) {
      return Account.fromJson(json.decode(_db['current_account']));
    }
  }

  static void setCurrentAccount(Account value) {
    _db['current_account'] = json.encode(value.toJson());
    _file.writeAsStringSync(json.encode(_db));
  }

  static void deleteCurrentAccount() {
    _db.remove('current_account');
    _file.writeAsStringSync(json.encode(_db));
  }
}