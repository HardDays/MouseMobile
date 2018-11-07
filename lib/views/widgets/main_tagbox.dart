import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class MainTagbox extends StatefulWidget {
  
  final bool checked;
  final String text;
  final Function onTap;
  final LinearGradient checkedGradient;
  final LinearGradient uncheckedGradient;
  final TextStyle textStyle;

  MainTagbox(this.text, 
    {
      this.onTap, 
      this.checkedGradient = const LinearGradient(
        colors: [
          AppColors.redRightGradButton,
          AppColors.redLeftGradButton,
        ]
      ), 
      this.uncheckedGradient = const LinearGradient(
        colors: [
          Color(0x16FFFFFF),
          Color(0x16FFFFFF),
        ]
      ),  
      this.checked = false,
      this.textStyle = const TextStyle(
        fontFamily: 'AvenirNext-Medium',
        color: Colors.white,
        fontSize: 15.0
      ),
    }
  );


  @override
  MainTagboxState  createState() =>  MainTagboxState();
}

class MainTagboxState extends State<MainTagbox> {

  @override
  void initState(){
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        decoration: BoxDecoration(
          gradient: widget.checked ? widget.checkedGradient : widget.uncheckedGradient,
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
              style: widget.textStyle
            ),
          ),
        )
      )
    );
  }
}