import 'package:flutter/material.dart';

import 'login_info_page.dart';
import 'notifications_page.dart';
import 'app_preferences_page.dart';
import 'feedback_page.dart';
import 'terms_page.dart';
import 'customer_support_page.dart';
import 'share_page.dart';

import '../../../start/start_page.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../../helpers/storage/data_provider.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class SettingsPage extends StatelessWidget {

  Widget buildSetting(BuildContext context, String text, Widget page){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          DefaultPageRoute(builder: (context) => page),
        );  
      },
      child: Container(
        color: Colors.transparent,
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
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                    size: 12.0,
                    color: Colors.white,
                  )
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

  Widget buildAppBar(BuildContext context){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              child: Text(Translations.settings.toUpperCase(),
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
              buildSetting(context, Translations.loginInfo, LoginInfoPage()),
              buildSetting(context, Translations.appPreferences, AppPreferencesPage()),
              //buildSetting(context, Translations.rewards, LoginInfoPage()),
              buildSetting(context, Translations.notifications, NotificationsPage()),
              buildSetting(context, Translations.feedback, FeedbackPage()),
              buildSetting(context, Translations.customerSupport, CustomerSupportPage()),
              buildSetting(context, Translations.termsOfService, TermsPage(Translations.mouseTerms, Translations.mouseTerms, Translations.termsText)),
              buildSetting(context, Translations.privacyPolicy, TermsPage(Translations.mousePrivacy, Translations.mouseTerms, Translations.privacyText)),
              buildSetting(context, Translations.shareMouse, SharePage()),
              GestureDetector(
                onTap: (){
                  DataProvider.flush();
                  Navigator.pushReplacement(
                    context, 
                    DefaultPageRoute(builder: (context) => StartPage()),
                  );  
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      margin: EdgeInsets.only(top: 50.0),
                      padding: EdgeInsets.only(left: 18.0, right: 18.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(3.0),
                          topRight: Radius.circular(3.0),
                          bottomRight: Radius.circular(20.0),
                        )
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(Translations.logout.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Avenir-Medium', 
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Icon(Icons.exit_to_app,
                            color: Colors.white,
                            size: 22.0,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(Translations.version,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16.0,
                  fontFamily: 'Avenir-Book', 
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}