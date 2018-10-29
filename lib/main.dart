import 'package:flutter/material.dart';

import 'views/pages/start/start_page.dart';
import 'views/pages/main/main_page.dart';

import 'helpers/storage/database.dart';

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
      if (Database.getCurrentUser() == null || Database.getCurrentAccount() == null){
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StartPage(),
        );
      } else {
        
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage(),
        );
      }
    }
  }
}
