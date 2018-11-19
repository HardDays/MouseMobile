import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:random_string/random_string.dart' as random;

import 'login_info_page.dart';
import 'notifications_page.dart';
import 'app_preferences_page.dart';
import 'feedback_page.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class SharePage extends StatelessWidget {

  String code;

  SharePage(){
    code = random.randomAlpha(6).toUpperCase();
  }

  void onShare(){
    Share.share('Visit MOUSE https://mouse-up.herokuapp.com');
  }

  Widget buildAppBar(BuildContext context){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              child: Text(Translations.share.toUpperCase(),
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
              Text(Translations.shareYourCode.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18.0,
                  fontFamily: 'Avenir-Medium'
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                child: Text(Translations.getYourFriends,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Book',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                child: Text(code,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textRed,
                    fontSize: 24.0,
                    fontFamily: 'Avenir-Black'
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                child: Text(Translations.moreFriends,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Book',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 45.0, left: 5.0, right: 5.0),
                child: Column(
                  children: <Widget>[ 
                    Text(Translations.shareIn.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Avenir-Book',
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          IconButton(
                            onPressed: onShare,
                            iconSize: 50.0,
                            icon: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/main/settings/copy.png')
                                )
                              ),
                            )
                          ),
                          IconButton(
                            onPressed: onShare,
                            iconSize: 50.0,
                            icon: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/main/settings/conv.png')
                                )
                              ),
                            )
                          ),
                           IconButton(
                            onPressed: onShare,
                            iconSize: 50.0,
                            icon: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/main/settings/google.png')
                                )
                              ),
                            )
                          ),
                           IconButton(
                            onPressed: onShare,
                            iconSize: 50.0,
                            icon: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/main/settings/facebook.png')
                                )
                              ),
                            )
                          ),
                           IconButton(
                            onPressed: onShare,
                            iconSize: 50.0,
                            icon: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/main/settings/twitter.png')
                                )
                              ),
                            )
                          ),
                        ],
                      )
                    )
                  ]
                ),
              )
            ]
          )
        ),
      )
    );
  }
}