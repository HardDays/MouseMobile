import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

import '../../models/api/account.dart';

import '../../helpers/storage/cache.dart';
import '../../helpers/api/main_api.dart';

class FollowButton extends StatefulWidget {
  
  LinearGradient gradient;

  Account account;
  
  FollowButton({
      this.gradient = const LinearGradient(
        colors: [
          AppColors.redRightGradButton,
          AppColors.redLeftGradButton,
        ]
      ), 
      this.account
    }
  );

  FollowButtonState createState()=> FollowButtonState();
}

class FollowButtonState extends State<FollowButton> {

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0)
          )
        ),
        child: Center(
          child: InkWell(
            onTap: (){
              setState(() {                      
                if (Cache.following.contains(widget.account.id)){
                  Cache.following.remove(widget.account.id);
                } else {
                  Cache.following.add(widget.account.id);
                }
              });
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 2.0),
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/common/follow_button_icon.png')
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 7.0)),
                Text(Cache.following.contains(widget.account.id) ? 'Unollow' : 'Follow',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 14.0
                  ),
                ),
              ] 
            )
          ),
        )
      )
    );
  }
}