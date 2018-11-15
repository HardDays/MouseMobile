import 'package:flutter/material.dart';

import '../../models/api/account.dart';

import '../pages/main/profile/followers_page.dart';
import '../routes/default_page_route.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

class FollowersButton extends StatefulWidget {
  Account account;

  FollowersButton({this.account});

  FollowersButtonState createState() => FollowersButtonState();
} 

class FollowersButtonState extends State<FollowersButton> {

  
  @override
  void initState(){
    super.initState();
   // widget.onChange = setState;
  }


  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[ 
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              DefaultPageRoute(builder: (context) => FollowersPage(id: widget.account.id, showFollowing: false)),
            );  
          },
          child: Row(
            children: <Widget>[
              Text('${widget.account.followersCount}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Avenir-Black',
                  fontSize: 16.0
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 5.0)),
              Text(Translations.followers,
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
              DefaultPageRoute(builder: (context) => FollowersPage(id: widget.account.id, showFollowing: true)),
            );  
          },
          child: Row(
            children: <Widget>[
              Text('${widget.account.followingCount}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Avenir-Black',
                  fontSize: 16.0
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 5.0)),
              Text(Translations.following,
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