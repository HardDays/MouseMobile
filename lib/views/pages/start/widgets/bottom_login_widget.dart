import 'package:flutter/material.dart';

import '../../main/main_page.dart';

import '../../../routes/default_page_route.dart';

import '../../../../resources/translations.dart';

class BottomLoginWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context){
     return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      height: MediaQuery.of(context).size.height * 0.185,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[                 
          Container(
            //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: Column(
              children: <Widget>[
                Text(Translations.loginWith,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            )
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/start/google_logo.png')
                    )
                  ),
                ),
                Container(
                  width: 30.0,
                  height: 30.0,
                  margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/start/fb_logo.png')
                    )
                  ),
                ),
                Container(
                  width: 30.0,
                  height: 30.0,
                  margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/start/twitter_logo.png')
                    )
                  ),
                ),
                Container(
                  width: 40.0,
                  height: 40.0,
                  margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/start/vk_logo.png')
                    )
                  ),
                )
              ],
            ),
          ),
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pushReplacement(
                context, 
                DefaultPageRoute(builder: (context) => MainPage()),
              );
            },
            child: Text(Translations.continueAsGuestCaps,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500
              ),
            ),
          )
        ]
      )
    );
  }
}