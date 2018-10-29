import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class MainButton extends StatelessWidget {
  
  final String text;
  final Function onTap;
  LinearGradient gradient;
  
  MainButton(this.text, {this.gradient = const LinearGradient(
        colors: [
          AppColors.redRightGradButton,
          AppColors.redLeftGradButton,
        ]
      ), 
      this.onTap
    }
  ) {
    
  }
  
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
            child: Text(text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 15.0
              ),
            ),
          ),
        )
      )
    );
  }
}