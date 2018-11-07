import 'package:flutter/material.dart';

import 'views/pages/start/start_page.dart';
import 'views/pages/main/main_page.dart';

import 'helpers/storage/database.dart';
import 'helpers/storage/cache.dart';

import 'helpers/api/main_api.dart';

void main() => runApp(App());


class App extends StatefulWidget {


  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  bool loading = true;

  @override
  void initState(){
    super.initState();
    Database.init().then((onValue){
      setState(() {
        loading = false;              
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading){
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(),
      );
    } else {
      if (Database.authorized()){
        MainAPI.updateToken(Database.getCurrentUser().token);

        var account = Database.getCurrentAccount();
        MainAPI.getAccount(account.id).then((res) {
          if (res != null){
            Database.setCurrentAccount(res);
          }
        });
        MainAPI.getFollowing(account.id).then((res) {
          Cache.following = res.map((acc) => acc.id).toList();
        });
        
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage(),
        );
      } else {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StartPage(),
        );
      }
    }
  }
}
