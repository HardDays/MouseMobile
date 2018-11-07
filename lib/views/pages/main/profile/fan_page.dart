  import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import 'widgets/account_header.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';
import '../../../widgets/followers_buttons.dart';

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
          AccountHeader(account: account),
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
                       color: Colors.white,
                       fontFamily: 'Avenir-Heavy',
                       fontSize: 13.0 
                     ),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                   child: Text('CAMPAIGNS',
                     style: TextStyle(
                       color: Colors.white,
                       fontFamily: 'Avenir-Heavy',
                       fontSize: 13.0 
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