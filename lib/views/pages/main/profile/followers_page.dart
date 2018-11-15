  import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import 'fan_page.dart';
import 'artist_page.dart';
import 'venue_page.dart';


import '../../../widgets/account_card.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';

class FollowersPage extends StatefulWidget {

  bool showFollowing;
  int id;

  FollowersPage({this.id, this.showFollowing = false});

  FollowersPageState createState() => FollowersPageState();
}

class FollowersPageState extends State<FollowersPage> with SingleTickerProviderStateMixin {

  List <Account> followers;
  List <Account> following;
  
  TabController tabController;

  @override
  void initState(){
    super.initState();

    tabController = TabController(length: 2, vsync: this, initialIndex: widget.showFollowing ? 1 : 0);
    
    tabController.addListener((){
      setState(() {});
    });

    if (followers == null){
      DataProvider.getFollowers(widget.id).then(
        (res) {
          setState(() {
            followers = res.result;                      
          });
        }
      );
    }
    if (following == null){
      DataProvider.getFollowing(widget.id).then(
        (res) {
          setState(() {
            following = res.result;                      
          });
        }
      );
    }
  }

  Widget buildList(List<Account> list, String title){
    if (list.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 115,
        child: Center(
          child: Text(title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontFamily: 'Avenir-Book', 
            ),
          )
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 115,
        child: ListView(
          children: List.generate(list.length, 
            (ind) {
              return AccountCard(account: list[ind]);
            }
          )
        ),
      );
    }
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Row(
          children:[
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(tabController.index == 0 ? Translations.followers.toUpperCase() : Translations.following.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Avenir-Black', 
                // fontStyle: FontStyle.italic
                ),
              )
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext ctx) {
    if (followers == null || following == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Container(
          child: Column(
            children: <Widget>[
               TabBar(
                indicatorColor: AppColors.textRed,
                controller: tabController,
                tabs: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12.0, bottom: 10.0),
                    child: Text(Translations.followers.toUpperCase(),
                      style: TextStyle(
                        color: tabController.index == 0 ? AppColors.textRed : Colors.grey.withOpacity(0.9),
                        fontFamily: 'Avenir-Heavy',
                        fontSize: 14.0 
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.0, bottom: 10.0),
                    child: Text(Translations.following.toUpperCase(),
                      style: TextStyle(
                        color: tabController.index == 1 ? AppColors.textRed : Colors.grey.withOpacity(0.9),
                        fontFamily: 'Avenir-Heavy',
                        fontSize: 14.0 
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 1.0, color: Colors.grey.withOpacity(0.5)),
              tabController.index == 0 ? 
              buildList(followers, Translations.noFollowers) : 
              buildList(following, Translations.noFollowing)
            ]
          )
        )
      );
    }
  }
}