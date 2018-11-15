import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_button.dart';
import '../widgets/main_tagbox.dart';
import '../widgets/address_autocomplete.dart';

import '../dialogs/dialogs.dart';

import '../routes/default_page_route.dart';

import '../../models/api/hour.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/storage/filters/location_filter.dart';

class HoursDialog extends StatefulWidget  {

  List <Hour> hours;

  HoursDialog({this.hours});

  @override
  HoursDialogState createState() => HoursDialogState();
}

class HoursDialogState extends State<HoursDialog> {

  Map<String, DateTime> begin;
  Map<String, DateTime> end;

  void initState(){
    super.initState();

    begin = {};
    end = {};
    for (var hour in Hours.all){
      begin[hour] = null;
      end[hour] = null;
    }

    for (var hour in widget.hours){
      begin[hour.day] = hour.beginTime;
      end[hour.day] = hour.endTime;
    }
  }

  @override 
  Widget build(BuildContext ctx){
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
     // height: MediaQuery.of(context).size.height * 0.37,
      decoration: BoxDecoration(
        color: AppColors.dialogBg,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Container(
        margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 30.0, bottom: 30.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(Hours.all.length, 
                      (ind) {
                        return Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(Translations.translateEnum(Hours.all[ind]).toUpperCase().substring(0, 3),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        );
                      }
                    )
                  )
                ),
                Container(
                  //width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(Hours.all.length, 
                      (ind) {
                        return begin[Hours.all[ind]] == null ||  end[Hours.all[ind]] == null ? 
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(Translations.closed,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ) :
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text('${DateFormat('h:mm a').format(begin[Hours.all[ind]]).toUpperCase()} - ${DateFormat('h:mm a').format(end[Hours.all[ind]]).toUpperCase()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        );
                      }
                    )
                  ),
                )
              ]
            ),
            Container(
              height: 40.0,
              margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: MainButton(Translations.dismiss.toUpperCase(), 
                onTap: () {
                  Navigator.pop(context);
                }
              ),
            )
          ]
        )
      )
    );
  }
}