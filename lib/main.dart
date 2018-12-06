import 'package:flutter/material.dart';

import 'views/pages/start/start_page.dart';
import 'views/pages/main/main_page.dart';
import 'views/pages/main/shows/player_page.dart';

import 'helpers/storage/data_provider.dart';



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
    DataProvider.init().then(
      (onValue){
        setState(() {
          loading = false;              
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {    
    //  return MaterialApp(
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: PlayerPage(url: 'https://www.omnivirt.com/360-video-player'),
    //   );
    if (loading){
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(),
      );
    } else {
      if (DataProvider.isAuthorized()){        
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
