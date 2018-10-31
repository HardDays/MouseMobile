import 'dart:async';

import 'package:flutter/material.dart';

import 'dates_filter_dialog.dart';
import 'genres_filter_dialog.dart';
import 'location_filter_dialog.dart';
import 'other_filter_dialog.dart';

import '../../resources/app_colors.dart';

import '../../helpers/storage/filters/dates_filter.dart';
import '../../helpers/storage/filters/genres_filter.dart';
import '../../helpers/storage/filters/location_filter.dart';
import '../../helpers/storage/filters/other_filter.dart';


class Dialogs {

  static void showLoader(BuildContext context){
    showDialog(context: context, 
      child: WillPopScope(
        onWillPop: (){
          Navigator.pop(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 1.0,
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(AppColors.mainRed)
            ),
          )
        )           
      )
    );
  }
  
  static Future showThemedDialog(BuildContext context, String title, Widget child) async {
    return await showDialog(context: context, 
      builder: (BuildContext context) {
        return Center(
          child: Material(
            //width: MediaQuery.of(context).size.width * 1.0,
            //height: MediaQuery.of(context).size.height * 0.5,
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 1.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/common/blured_rect.png'),
                  fit: BoxFit.cover
                )
              ),
              //filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
               
                //color: AppColors.dialogBack,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Stack(
                    children:[
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(color: Colors.transparent),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
                        child: IconButton(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.all(0.0),
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Column( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 3.0),
                            child: Text(title,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: child
                        )
                      ]
                    )
                  ]
                )
              )
            )
          )    
        );
      }
    );
  }

  static Future showDatesFilterDialog(BuildContext context, {DatesFilter filter, Function(DatesFilter) onSave}) async {
    return await showThemedDialog(context, 'DATE', DatesFilterDialog(filter: filter, onSave: onSave));
  }

  static void showGenresFilterDialog(BuildContext context, {GenresFilter filter, Function(GenresFilter) onSave}){
    Dialogs.showThemedDialog(context, 'GENRE', GenresFilterDialog(filter: filter, onSave: onSave));
  }

  static void showLocationFilterDialog(BuildContext context, {LocationFilter filter, Function(LocationFilter) onSave}){
    Dialogs.showThemedDialog(context, 'LOCATION', LocationFilterDialog(filter: filter, onSave: onSave));
  }

  static void showOtherFilterDialog(BuildContext context, {OtherFilter filter, Function(OtherFilter) onSave}){
    Dialogs.showThemedDialog(context, 'OTHER FILTERS', OtherFilterDialog(filter: filter, onSave: onSave));
  }


  static void showMessage(BuildContext context, String title, String body, String ok){
    showDialog(context: context, 
      child: AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          FlatButton(
            child: Text(ok),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ],
      )
    );
  }

  static void showYesNo(BuildContext context, String title, String body, String yes, String no, Function onYes, Function onNo){
    showDialog(context: context, 
      child: AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          FlatButton(
            child: Text(yes),
            onPressed: onYes
          ),
          FlatButton(
            child: Text(no),
            onPressed: onNo                               
          ),               
        ],
      )
    );
  }
}