import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_button.dart';
import '../widgets/main_tagbox.dart';
import '../widgets/main_checkbox.dart';

import '../dialogs/dialogs.dart';

import '../routes/default_page_route.dart';

import '../../models/api/genre.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/storage/filters/genres_filter.dart';

class MessageDialog extends StatefulWidget  {

  String body;
  String ok;

  MessageDialog({this.body, this.ok});

  @override
  MessageDialogState createState() => MessageDialogState();
}

class MessageDialogState extends State<MessageDialog> {

  void initState(){
    super.initState();
  }

  @override 
  Widget build(BuildContext ctx){
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      //height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      decoration: BoxDecoration(
        color: AppColors.dialogBg,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 40.0, right: 40.0),
            child: Text(widget.body,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Avenir-Medium', 
                fontSize: 16.0
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 40.0, top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(widget.ok.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Book', 
                      fontSize: 16.0
                    )
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }
}