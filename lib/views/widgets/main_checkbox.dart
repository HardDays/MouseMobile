import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class MainCheckbox extends StatefulWidget {
  
  bool checked;
  String text;
  Function onTap;
  LinearGradient checkedGradient;
  LinearGradient uncheckedGradient;

  MainCheckbox({this.checkedGradient = const LinearGradient(
        colors: [
          AppColors.redRightGradButton,
          AppColors.redLeftGradButton,
        ]
      ), 
      this.uncheckedGradient = const LinearGradient(
        colors: [
          Colors.transparent,
          Colors.transparent,
        ]
      ),  
      this.onTap, 
      this.checked = false}){
  }

  @override
  MainCheckboxState  createState() => MainCheckboxState();
}

class MainCheckboxState extends State<MainCheckbox> {
  
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
        width: 23.0,
        height: 23.0,
        //padding: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: BoxDecoration(
          gradient: checked ? widget.checkedGradient : widget.uncheckedGradient,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3.0),
            bottomRight: Radius.circular(3.0),
            topRight: Radius.circular(3.0),
            bottomLeft: Radius.circular(3.0)
          ),
          border: Border.all(color: checked ? Colors.transparent : Colors.grey.withOpacity(0.5))
        ),
        child: Center(
          child: InkWell(
            onTap: (){
              /*setState(() {
                checked = !checked;                
              });*/
              if (widget.onTap != null){
                widget.onTap();
              }
            },
            child: checked ? 
            Icon(Icons.check,
              size: 20.0,
              color: Colors.white,
            ) : 
            Container()
          ),
        )
      )
    );
  }
}