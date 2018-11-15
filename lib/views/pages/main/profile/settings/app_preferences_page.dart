import 'package:flutter/material.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../widgets/main_checkbox.dart';

import '../../../../dialogs/dialogs.dart';

import '../../../../../models/api/preferences.dart';

import '../../../../../helpers/storage/data_provider.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';


class AppPreferencesPage extends StatefulWidget {

  AppPreferencesPageState createState() => AppPreferencesPageState();
}

class AppPreferencesPageState extends State<AppPreferencesPage> {

  Preferences preferences;

  @override
  void initState(){
    super.initState();

    preferences = DataProvider.preferences;
  }

  Widget buildSetting(String text, Widget child, {Function onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  child
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.15),
              height: 1.0,
            ),
          ]
        )
      )
    );
  }

  Widget buildTextSetting(String text){
    return Container(
      child: Text('$text  •',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: 'Avenir-Medium', 
        ),
      ),
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
              child: Text('APP PREFERENCES',
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
                child: Text('REGIONAL OPTIONS',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Medium', 
                  ),
                ),
              ),
              buildSetting('Language', buildTextSetting(preferences.language), 
                onTap: (){
                  Dialogs.showSelectDialog(context, 
                    title: 'Language', 
                    options: Language.all,//['English', 'Russian'], 
                    singleSelect: true,
                    selected: [preferences.language],
                    onSave: (res){
                      setState(() {
                        preferences.language = res.first; 
                        DataProvider.setPreferences(preferences);                                             
                      });
                    }
                  );
                }
              ),
              buildSetting('Date', buildTextSetting(preferences.dateFormat), 
                onTap: (){
                  Dialogs.showSelectDialog(context, 
                    title: 'Date format', 
                    options: DateFormatting.all,// ['MMDDYYYY', 'DDMMYYYY'], 
                    singleSelect: true,
                    selected: [preferences.dateFormat],
                     onSave: (res){
                      setState(() {
                        preferences.dateFormat = res.first;
                        DataProvider.setPreferences(preferences);                                              
                      });
                    }
                  );
                }
              ),
              buildSetting('Distance', buildTextSetting(preferences.distance), 
                onTap: (){
                  Dialogs.showSelectDialog(context, 
                    title: 'Distance', 
                    options: Distance.all, //['Miles', 'Kilometers'], 
                    singleSelect: true,
                    selected: [preferences.distance],
                     onSave: (res){
                      setState(() {
                        preferences.distance = res.first;
                        DataProvider.setPreferences(preferences);                                              
                      });
                    }
                  );
                }
              ),         
              buildSetting('Currency', buildTextSetting(preferences.currency), 
                onTap: (){
                  Dialogs.showSelectDialog(context,
                    title: 'Currency', 
                    options: Currency.all, // ['US Dollar (\$)', 'Euro (€)', 'Ruble (₽)'], 
                    singleSelect: true,
                    selected: [preferences.currency],
                     onSave: (res){
                      setState(() {
                        preferences.currency = res.first;             
                        DataProvider.setPreferences(preferences);                                 
                      });
                    }
                  );
                }
              ),         
              buildSetting('Time', 
                Row(
                  children: <Widget>[
                    Text('12 Hour',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Avenir-Medium', 
                      ),
                    ),
                    Switch(
                      activeColor: AppColors.mainRed,
                      inactiveThumbColor: AppColors.mainRed,
                      activeTrackColor: Colors.white.withOpacity(0.2),
                      inactiveTrackColor: Colors.white.withOpacity(0.2),
                      value: preferences.timeFormat == TimeFormatting.t24,
                      onChanged: (val){
                        setState(() {
                          if (preferences.timeFormat == TimeFormatting.t24){
                            preferences.timeFormat = TimeFormatting.t12;
                          } else {
                            preferences.timeFormat = TimeFormatting.t24;
                          }                        
                          DataProvider.setPreferences(preferences);
                        });
                      },
                    ),
                    Text('24 Hour',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Avenir-Medium', 
                      ),
                    ),
                  ],
                )
              ),
            ]
          ),
        )
      )
    );
  }
}