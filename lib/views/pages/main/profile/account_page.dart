  import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import 'fan_page.dart';
import 'artist_page.dart';
import 'venue_page.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/main_button.dart';
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

class AccountPage extends StatefulWidget {

  int id;

  AccountPage({this.id});

  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin {

  Account account;
  
  @override
  void initState(){
    super.initState();

    if (account == null){
      MainAPI.getAccount(widget.id).then(
        (account) async {
          if (account == null){
            Dialogs.showMessage(context, 
              title: 'Can\'t load account', 
              body: 'Account is suspended',
              ok: Translations.ok
            ).then(
              (res){
                Navigator.pop(context);
              }
            );
          }
          setState(() {
            this.account = account;             
          });
        }
      );
    }
  }

  Widget buildContent(){
    if (account.accountType == AccountType.fan){
      return FanPage(account: account);
    } else if (account.accountType == AccountType.artist){
      return ArtistPage(account: account);
    } else {
      return VenuePage(account: account);
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
              child: Text(account == null ? 'ACCOUNT' : account.displayName?.toUpperCase() ?? '@${account.userName}',
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
    if (account == null) {
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: buildContent()
      );
    }
  }
}