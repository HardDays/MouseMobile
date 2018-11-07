import 'package:flutter/material.dart';

import '../../models/api/account.dart';

import '../pages/main/profile/followers_page.dart';
import '../routes/default_page_route.dart';

import '../../resources/app_colors.dart';

class FollowersButton extends StatelessWidget {

  Account account;

  FollowersButton({this.account});
  
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[ 
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              DefaultPageRoute(builder: (context) => FollowersPage(id: account.id, showFollowing: false)),
            );  
          },
          child: Row(
            children: <Widget>[
              Text('${account.followersCount}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Avenir-Black',
                  fontSize: 16.0
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 5.0)),
              Text('Followers',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Avenir-Book',
                  fontSize: 16.0
                ),
              )
            ],
          )
        ),
        Padding(padding: EdgeInsets.only(left: 25.0)),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              DefaultPageRoute(builder: (context) => FollowersPage(id: account.id, showFollowing: true)),
            );  
          },
          child: Row(
            children: <Widget>[
              Text('${account.followingCount}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Avenir-Black',
                  fontSize: 16.0
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 5.0)),
              Text('Following',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Avenir-Book',
                  fontSize: 16.0
                ),
              )
            ],
          )
        )
      ],
    );
  }
}