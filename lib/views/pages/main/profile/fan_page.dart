  import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/storage/cache.dart';

class FanPage extends StatefulWidget {

  Account account;

  FanPage({this.account});

  FanPageState createState() => FanPageState();
}

class FanPageState extends State<FanPage> with SingleTickerProviderStateMixin {
  
  Account account;

  TabController tabController;

  @override
  void initState(){
    super.initState();

    account = widget.account;

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(
      () {
        setState(() {
                  
        });
      }
    );
  }

  Widget buildFavorites(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Text('No favorites',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0
          ),
        )
      ),
    );
  }

  Widget buildCampaigns(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Text('No campaigns',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0
          ),
        )
      ),
    );
  }

  @override 
  Widget build(BuildContext ctx) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/main/profile/account_header.png')
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
                width: 100.0,
                height: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: AccountImage(account: account)
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 110.0, right: 15.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 30.0,
                  child: FollowButton()
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70.0, right: 15.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/main/profile/fan_icon.png')
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Text('FAN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                )
              ),
            ]
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
            child: Text(account.displayName ?? 'Unnamed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Text('@',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.mainRed,
                    fontSize: 16.0
                  ),
                ),
                Text(account.userName ?? '',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
          account.bio != null ? 
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
            child: Text(account.bio,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400
              ),
            ),
          ) : 
          Container(),

          account.genres.isNotEmpty ? 
          Container(
            margin: EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
            height: 25.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(account.genres.length, 
                (ind) {
                  return Container(
                    margin: EdgeInsets.only(right: 7.0),
                    child: MainTagbox(Translations.translateEnum(account.genres[ind]).toUpperCase(),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0
                      ),
                      uncheckedGradient: LinearGradient(
                        colors: [
                          Colors.grey.withOpacity(0.2),
                          Colors.grey.withOpacity(0.2),
                        ]
                      ),
                    )
                  );
                }
              )
            )
          ) :
          Container(),
          
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 20.0),
            child: Row(
              children: <Widget>[ 
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Text('${account.followersCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      Text('Followers',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0
                        ),
                      )
                    ],
                  )
                ),
                Padding(padding: EdgeInsets.only(left: 25.0)),
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Text('${account.followingCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      Text('Following',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0
                        ),
                      )
                    ],
                  )
                )
              ],
            )
          ),
          Container(
             margin: EdgeInsets.only(top: 20.0),
             color: AppColors.appBar,
             child: TabBar(
               indicatorColor: Colors.white,
               controller: tabController,
               tabs: <Widget>[
                 Container(
                   margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                   child: Text('FAVORITES',
                     style: TextStyle(
                       color: Colors.white
                     ),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                   child: Text('CAMPAIGNS',
                     style: TextStyle(
                       color: Colors.white
                     ),
                   ),
                 ),
               ],
             )
           ),
           tabController.index == 0 ? buildFavorites() : buildCampaigns()
        ],
      ),
    );
  }
}