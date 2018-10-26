import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class MainTagbox extends StatefulWidget {
  
  bool checked;
  String text;
  Function onTap;
  LinearGradient checkedGradient;
  LinearGradient uncheckedGradient;

  MainTagbox(this.text, {this.checkedGradient, this.uncheckedGradient,  this.onTap, this.checked}){
    if (checkedGradient == null){
      checkedGradient = LinearGradient(
        colors: [
          AppColors.redRightGradButton,
          AppColors.redLeftGradButton,
        ]
      );
    }
    if (uncheckedGradient == null){
      uncheckedGradient = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.07),
          Colors.white.withOpacity(0.07),
        ]
      );
    }
    if (checked == null){
      checked = false;
    }
  }

  @override
  MainTagboxState  createState() => MainTagboxState();
}

class MainTagboxState extends State<MainTagbox> {
  
  bool checked;

  @override
  void initState(){
    super.initState();

    checked = widget.checked;
  }
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: BoxDecoration(
          gradient: checked ? widget.checkedGradient : widget.uncheckedGradient,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3.0),
            bottomRight: Radius.circular(3.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0)
          )
        ),
        child: Center(
          child: InkWell(
            onTap: (){
              setState(() {
               // checked = !checked;                
              });
              if (widget.onTap != null){
                widget.onTap();
              }
            },
            child: Text(widget.text,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 14.0
              ),
            ),
          ),
        )
      )
    );
  }
}