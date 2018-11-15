import 'package:flutter/material.dart';

import '../dialogs/dialogs.dart';

import '../../resources/app_colors.dart';

import '../../models/api/account.dart';

import '../../helpers/storage/data_provider.dart';


class FollowButton extends StatefulWidget {
  
  Account account;
    
  FollowButton({this.account}){

  }

  FollowButtonState createState()=> FollowButtonState();
}

class FollowButtonState extends State<FollowButton> {
  bool loading = false;

  @override
  void initState(){
    super.initState();
  }

  void onFollow(){
    if (DataProvider.isAuthorized()){
      if (!loading){
        loading = true;
        if (DataProvider.getMyFollowing().contains(widget.account.id)){
          DataProvider.unfollow(widget.account.id).then(
            (res){
              setState(() {
                loading = false;                                       
              });
            }
          );
        } else {
          DataProvider.follow(widget.account.id).then(
            (res){
              setState(() {
                loading = false;                                       
              });
            }
          );
        }
      }
    } else {
      Dialogs.showMessageDialog(context, title: 'Unauthorized', body: 'Please, log in for this action', ok: 'Ok');
    }
  }

  Widget build(BuildContext context) {
    bool followed = DataProvider.getMyFollowing().contains(widget.account.id);
    
    return GestureDetector(
      onTap: onFollow,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.redRightGradButton,
              AppColors.redLeftGradButton,
            ]
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0)
          )
        ),
        child: Center(
          child: InkWell(
            onTap: onFollow,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 2.0),
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(followed ? 'assets/images/common/unfollow_button_icon.png' : 'assets/images/common/follow_button_icon.png')
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 7.0)),
                Text(followed ? 'Unollow' : 'Follow',
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