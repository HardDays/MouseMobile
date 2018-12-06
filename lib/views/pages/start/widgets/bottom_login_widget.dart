import 'package:flutter/material.dart';
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';

import '../vk_login_page.dart';
import '../fb_login_page.dart';

import '../../main/main_page.dart';

import '../../main/shows/player_page.dart';

import '../../../dialogs/dialogs.dart';

import '../../../routes/default_page_route.dart';

import '../../../../helpers/storage/data_provider.dart';

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
                    fontFamily: 'Avenir-Heavy',
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
                // Container(
                //   width: 40.0,
                //   height: 40.0,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage('assets/images/start/google_logo.png')
                //     )
                //   ),
                // ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context, 
                      DefaultPageRoute(builder: (context) => FbLoginPage()),
                    );
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    //margin: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/start/fb_logo.png')
                      )
                    ),
                  ),           
                ),
                GestureDetector(
                  // onTap: () async {
                  //   var twitterLogin = new TwitterLogin(
                  //     consumerKey: 'TVm4kOpBBBjRwyCa9gAJ6SGzn',
                  //     consumerSecret: '7t6Yq20UCEBoJKTmwrNFMItoglFvCxWRQXx31LUqd7BO3dWGgY',
                  //   );
                  //   TwitterLoginResult result = await twitterLogin.authorize();
                  //   if (result.status == TwitterLoginStatus.loggedIn){
                  //     Dialogs.showLoader(context);
                  //     var res = await DataProvider.loginTwitter(result.session.token, result.session.secret);
                  //     Navigator.pop(context);
                  //     if (res.status == DataStatus.ok){ 
                  //       while(Navigator.canPop(context)){
                  //         Navigator.pop(context);
                  //       }
                  //       Navigator.pushReplacement(
                  //         context, 
                  //         DefaultPageRoute(builder: (context) => MainPage()),
                  //       );     
                  //     } else {
                  //       Dialogs.showMessageDialog(context, title: Translations.unauthorized, body: Translations.wrongUsernameOrPass, ok: Translations.ok);
                  //     }  
                  //   } else {
                  //     Dialogs.showMessageDialog(context, title: Translations.unauthorized, body: Translations.wrongUsernameOrPass, ok: Translations.ok);
                  //   }  
                  // },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    margin: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/start/twitter_logo.png')
                      )
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context, 
                      DefaultPageRoute(builder: (context) => VkLoginPage()),
                    );
                  },
                  child: Container(
                      width: 40.0,
                      height: 40.0,
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/start/vk_logo.png')
                        )
                      ),
                    )
                 )
              ],
            ),
          ),
          FlatButton(
            onPressed: (){
              while (Navigator.canPop(context)){
                Navigator.pop(context);
              }
              // Navigator.push(
              //   context, 
              //   DefaultPageRoute(builder: (context) => PlayerPage()),
              // );
              // return;
              Navigator.pushReplacement(
                context, 
                DefaultPageRoute(builder: (context) => MainPage()),
              );
            },
            child: Text(Translations.continueAsGuest.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Avenir-Heavy',
              ),
            ),
          )
        ]
      )
    );
  }
}