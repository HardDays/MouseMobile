import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'account_image.dart';
import 'main_tagbox.dart';

import '../pages/main/profile/account_page.dart';
import '../routes/default_page_route.dart';
import '../dialogs/dialogs.dart';

import '../../models/api/account.dart';

import '../../helpers/storage/data_provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';


class AccountCard extends StatefulWidget {
  
  Account account;
    
  AccountCard({this.account}){

  }

  AccountCardState createState()=> AccountCardState();
}

class AccountCardState extends State<AccountCard> {

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
      Dialogs.showMessage(context, title: 'Unauthorized', body: 'Please, log in for this action', ok: 'Ok');
    }
  }
  
  Widget build(BuildContext context) {
    bool followed = DataProvider.getMyFollowing().contains(widget.account.id);

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          DefaultPageRoute(builder: (context) => AccountPage(id: widget.account.id)),
        );  
      },
      child: Container(
        color: Colors.white,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AccountImage(account: widget.account),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.account.displayName ?? 'Unnamed',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Avenir-Medium', 
                                  fontSize: 16.0
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 0.0)),  
                              Row(
                                children: <Widget>[
                                  Text('@',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Avenir-Book', 
                                      color: AppColors.mainRed,
                                      fontSize: 13.0
                                    ),
                                  ),
                                  Text(widget.account.userName ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Avenir-Book', 
                                      color: Colors.black,
                                      fontSize: 13.0
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 0.0)),  
                              Text((widget.account.address ?? widget.account.preferredAddress) ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Avenir-Book', 
                                  fontSize: 12.0
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: IconButton(
                        onPressed: onFollow,
                        icon: Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(followed ? 'assets/images/common/unfollow_icon.png' : 'assets/images/common/follow_icon.png')
                            )
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
              widget.account.accountType == AccountType.artist && widget.account.genres.isNotEmpty ? 
              Container(
                height: 35.0,
                width: MediaQuery.of(context).size.width * 1.0 - 90,
                margin: EdgeInsets.only(left: 90.0, right: 30.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(widget.account.genres.length, 
                    (ind) {
                      return Container(
                        margin: EdgeInsets.only(top: 0.0, bottom: 10.0, right: 7.0),
                        child: MainTagbox(Translations.translateEnum(widget.account.genres[ind]).toUpperCase(),
                          textStyle: TextStyle(
                            color: AppColors.genresText,
                            fontSize: 12.0,
                            fontFamily: 'Avenir-Book', 
                          ),
                          uncheckedGradient: LinearGradient(
                            colors: [
                              Colors.grey.withOpacity(0.3),
                              Colors.grey.withOpacity(0.3),
                            ]
                          ),
                        )
                      );
                    }
                  )
                )
              ) 
              :
              Container(),
              Padding(padding: EdgeInsets.only(top: 0.0)),
              Divider(color: Colors.grey, height: 2.0,)
            ] 
          )
        )
      )
    );
  }
}