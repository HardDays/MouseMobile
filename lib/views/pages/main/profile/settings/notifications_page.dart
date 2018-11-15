import 'package:flutter/material.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../widgets/main_checkbox.dart';

import '../../../../../helpers/storage/data_provider.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class NotificationsPage extends StatefulWidget {

  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {

  @override
  void initState(){
    super.initState();

  }

  Widget buildSetting(String text){
    return Container(
      color: AppColors.dialogBg,
      child: Column(
        children:[
          Divider(
            color: Colors.grey.withOpacity(0.15),
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(text,
                  style: TextStyle(
                    fontFamily: 'Avenir-Book',
                    fontSize: 18.0,
                    color: Colors.white
                  ),
                ),
                Container(
                  child: MainCheckbox(
                    onTap: (){
                    },
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.15),
            height: 1.0,
          ),
        ]
      )
    );
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              child: Text('NOTIFICATIONS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Avenir-Black', 
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: buildAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainBg,
              AppColors.dialogBg
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15.0, top: 25.0, bottom: 15.0),
                child: Text('SHOWS AND MESSAGES',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Medium', 
                  ),
                ),
              ),
              buildSetting('New Shows Near You'),
              buildSetting('New Shows From Favorite Artist'),
              buildSetting('Messages Sent to You'),
              Container(
                margin: EdgeInsets.only(left: 15.0, top: 25.0, bottom: 15.0),
                child: Text('SHOWS NOTIFICATION FREQUENCY',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Medium', 
                  ),
                ),
              ),
              buildSetting('Daily'),
              buildSetting('Weekly'),
              buildSetting('Monthly'),
            ]
          ),
        )
      )
    );
  }
}