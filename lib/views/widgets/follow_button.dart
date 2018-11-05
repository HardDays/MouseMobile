import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class FollowButton extends StatelessWidget {
  
  final Function onTap;
  LinearGradient gradient;
  
  FollowButton({this.gradient = const LinearGradient(
        colors: [
          AppColors.redRightGradButton,
          AppColors.redLeftGradButton,
        ]
      ), 
      this.onTap
    }
  );
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0)
          )
        ),
        child: Center(
          child: InkWell(
            onTap: onTap,
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
                Text('Follow',
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