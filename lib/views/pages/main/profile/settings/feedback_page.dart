import 'package:flutter/material.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../widgets/main_checkbox.dart';

import '../../../../../helpers/storage/data_provider.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class FeedbackPage extends StatefulWidget {

  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {

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
              child: Text('FEEDBACK',
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
                child: Text('I\'M TELLING YOU ABOUT',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Medium', 
                  ),
                ),
              ),
              buildSetting('A Bug'),
              buildSetting('An Enchancement'),
              buildSetting('Compliment'),
              Container(
                margin: EdgeInsets.only(left: 15.0, top: 25.0, bottom: 5.0),
                child: Text('DETAILS',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Medium', 
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 13.0, right: 13.0),
                child: TextField(
                  maxLines: 5,
                  maxLength: 1000,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontFamily: 'Avenir-Book', 
                    fontSize: 16.0
                  ),
                  decoration: InputDecoration(
                    helperStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontFamily: 'Avenir-Book', 
                    ),
                    contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3)
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3)
                      )
                    ),    
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text('HOW ARE WE DOING?',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16.0,
                        fontFamily: 'Avenir-Medium', 
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text('Please Rate Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Avenir-Book', 
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, 
                        (ind) {
                          return Container(
                            child: IconButton(
                              iconSize: 35.0,
                              icon: Icon(Icons.star,
                                color: Colors.yellow,
                              ),

                            )
                          );
                        }
                      ),
                    )
                  ],
                ),
              )
            ]
          ),
        )
      )
    );
  }
}