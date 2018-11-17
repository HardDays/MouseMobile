import 'package:flutter/material.dart';

import 'login_info_page.dart';
import 'notifications_page.dart';
import 'app_preferences_page.dart';
import 'feedback_page.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class TermsPage extends StatelessWidget {
  String pageName;
  String title;
  String text;

  TermsPage(this.pageName, this.title, this.text);

  Widget buildAppBar(BuildContext context){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              child: Text(pageName.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Avenir-Black', 
                ),
              )
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [
          
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(title.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18.0,
                  fontFamily: 'Avenir-Medium'
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Text(text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontFamily: 'Avenir-Book'
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}