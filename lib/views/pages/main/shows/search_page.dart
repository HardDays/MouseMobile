import 'dart:async';

import "package:google_maps_webservice/places.dart";
import 'package:flutter/material.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/main_checkbox.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/storage/cache.dart';

class SearchPage extends StatefulWidget {
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>  {

  @override
  void initState(){
    super.initState();
  }

  @override 
  Widget build(BuildContext ctx) {
    return Scaffold(
   //   key: _scaffoldKey,
      backgroundColor: AppColors.mainBg,
      appBar: PreferredSize( 
        preferredSize: Size(MediaQuery.of(context).size.width, 40.0),
        child: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.appBar,
          title: TextField(
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 17.0
            ),
            decoration: InputDecoration.collapsed(
              hintText: 'Search',       
              hintStyle: TextStyle(
                fontFamily: 'Lato',
                color: Colors.grey.withOpacity(0.5)
              )     
            ),
            onChanged: (value) async {
              
            },          
            onSubmitted: (value) async {       
            
            },
          ),    
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
              Divider(
              color: Colors.grey.withOpacity(0.3),
              height: 2.0
            ),
            Container(
              height: 50.0,
              alignment: Alignment.center,
              color: AppColors.appBar,
              padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 2.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 3.0, left: 3.0),
                    height: 30.0,
                    child: MainTagbox('SHOWS',
                      checked: false,
                      uncheckedGradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent
                        ]
                      ),
                    ),
                  ),
                  
                ]                  
              ),
            )
          ]
        ),
      ),
    );
  }
}