import 'package:flutter/material.dart';

import '../../../widgets/main_button.dart';

import '../../start/start_page.dart';

import '../../../routes/default_page_route.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/database.dart';
import '../../../../helpers/storage/cache.dart';

class ProfilePage extends StatefulWidget  {

  final String title = Translations.profile.toUpperCase();
  final String icon = 'assets/images/main/profile_tab_icon.svg';

  Widget appBar;
  Function(Widget) onLoad;

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (context != null){
          buildAppBar(context);
        }
      }
    );
  }

  void buildAppBar(BuildContext context){
    widget.appBar = PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 40.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              width: 25.0,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(                               
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/start/mouse_logo.png'),
                  ),
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(left: 10.0)),
            Text(widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500
               // fontStyle: FontStyle.italic
              ),
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {   
              Cache.events = null;
              Database.deleteCurrentAccount();
              Database.deleteCurrentUser();
              Navigator.pushReplacement(
                context, 
                DefaultPageRoute(builder: (context) => StartPage()),
              );              
            }
          )
        ]
      )
    );
    widget.onLoad(widget.appBar);
  } 

  @override 
  Widget build(BuildContext ctx) {
    return Container(
      color: AppColors.mainBg,
      child: SingleChildScrollView(
        
      ),
    );
  }
}