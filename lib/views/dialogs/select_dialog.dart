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

class SelectDialog extends StatefulWidget  {

  bool singleSelect;

  Function(List<String>) onSave;

  List<String> options;
  List<String> selected;

  SelectDialog({this.singleSelect = true, this.selected = const [], this.options = const [], this.onSave});

  @override
  SelectDialogState createState() => SelectDialogState();
}

class SelectDialogState extends State<SelectDialog> {

  Set<String> selected;

  void initState(){
    super.initState();

    selected = widget.selected.toSet();
  }

  void onSelect(String val){
    setState(
      () {
        if (widget.singleSelect){
          selected.clear();
        }
        if (selected.contains(val)){
          selected.remove(val);
        } else {
          selected.add(val);
        }                        
      }
    );
  }

  @override 
  Widget build(BuildContext ctx){
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      //height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: AppColors.dialogBg,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              children: List.generate(widget.options.length, 
                (ind) {
                  return GestureDetector( 
                    onTap: (){
                      onSelect(widget.options[ind]);
                    },
                    child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: <Widget>[
                          MainCheckbox(
                            checked: selected.contains(widget.options[ind]),
                            onTap: (){
                              onSelect(widget.options[ind]);
                            },
                          ),
                          Padding(padding: EdgeInsets.only(left: 15.0)),
                          Flexible(
                            child: Text(widget.options[ind],
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Avenir-Book', 
                                fontSize: 16.0
                              )
                            ),
                          ),
                        ],
                      )
                    )
                  );
                }
              )
            )
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width * 0.3,
              height: 40.0,
              child: MainButton('SAVE', 
                onTap: (){
                  if (widget.onSave != null){
                    widget.onSave(selected.toList());
                  }
                  Navigator.pop(context);
                }
              )
            )
          )
        ],
      )
    );
  }
}