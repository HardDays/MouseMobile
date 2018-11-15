import 'package:flutter/material.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../../helpers/storage/data_provider.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class LoginInfoPage extends StatefulWidget {

  LoginInfoPageState createState() => LoginInfoPageState();
}

class LoginInfoPageState extends State<LoginInfoPage> {

  @override
  void initState(){
    super.initState();

  }

  Widget buildSetting(String text, String value, Widget page){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          DefaultPageRoute(builder: (context) => page),
        );  
      },
      child: Container(
        color: AppColors.dialogBg,
        child: Column(
          children:[
            Divider(
              color: Colors.grey.withOpacity(0.15),
              height: 1.0,
            ),
            Container(
              padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(text,
                    style: TextStyle(
                      fontFamily: 'Avenir-Book',
                      fontSize: 16.0,
                      color: Colors.white.withOpacity(0.5)
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(value,
                        style: TextStyle(
                          fontFamily: 'Avenir-Book',
                          fontSize: 18.0,
                          color: Colors.white
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Icon(Icons.arrow_forward_ios,
                        size: 12.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.15),
              height: 1.0,
            ),
          ]
        )
      )
    );
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              child: Text(Translations.loginInfo,
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
      appBar: buildAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainBg,
              AppColors.dialogBg
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15.0)),
              buildSetting(Translations.email.toUpperCase(), DataProvider.currentUser.email, LoginInfoPage()),
              buildSetting(Translations.password.toUpperCase(), '', LoginInfoPage()),
              buildSetting(Translations.phoneNumber.toUpperCase(), '', LoginInfoPage()),
            ]
          ),
        )
      )
    );
  }
}