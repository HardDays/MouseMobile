import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

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
  
  static void showThemedDialog(BuildContext context, Widget child){
    showDialog(context: context, 
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
            child: Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                //height: MediaQuery.of(context).size.height * 0.5,
                child: Stack( 
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 3.0),
                      child: Text('GENRE',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32.0),
                    child: child
                  )
                ]
              )
            )
          )
        );
      }
    );
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