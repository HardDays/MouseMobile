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

  void update(){
    setState(() {
      DataProvider.setPreferences(preferences);
    });
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
              child: Text(Translations.appPreferences.toUpperCase(),
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
                child: Text(Translations.regionalOptions.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Medium', 
                  ),
                ),
              ),
              buildSetting(Translations.language, buildTextSetting(Translations.translateEnum(preferences.language)), 
                onTap: (){
                  var options = [Translations.translateEnum(Language.engilsh), Translations.translateEnum(Language.russian)];
                  Dialogs.showSelectDialog(context, 
                    title: Translations.language, 
                    options: options,
                    singleSelect: true,
                    selected: [Translations.translateEnum(preferences.language)],
                    onSave: (res){
                      setState(() {
                        preferences.language = Language.all[options.indexOf(res.first)]; 
                        update();
                      });
                    }
                  );
                }
              ),
              buildSetting(Translations.date, buildTextSetting(preferences.dateFormat), 
                onTap: (){
                  Dialogs.showSelectDialog(context, 
                    title: Translations.dateFormat, 
                    options: DateFormatting.all,
                    singleSelect: true,
                    selected: [preferences.dateFormat],
                     onSave: (res){
                      setState(() {
                        preferences.dateFormat = res.first;
                        update();
                      });
                    }
                  );
                }
              ),
              buildSetting(Translations.distance, buildTextSetting(Translations.translateEnum(preferences.distance)), 
                onTap: (){
                  var options = [Translations.translateEnum(Distance.kilometers), Translations.translateEnum(Distance.miles)];
                  Dialogs.showSelectDialog(context, 
                    title: Translations.distance, 
                    options: options,
                    singleSelect: true,
                    selected: [Translations.translateEnum(preferences.distance)],
                     onSave: (res){
                      setState(() {
                        preferences.distance = Distance.all[options.indexOf(res.first)];
                        update();
                      });
                    }
                  );
                }
              ),         
              buildSetting(Translations.currency, buildTextSetting(Translations.translateEnum('text${preferences.currency}')), 
                onTap: (){
                  var options = [Translations.translateEnum('text${Currency.ruble}'), 
                                Translations.translateEnum('text${Currency.dollar}'),
                                Translations.translateEnum('text${Currency.euro}')];
                  Dialogs.showSelectDialog(context,
                    title: Translations.currency, 
                    options: options,
                    singleSelect: true,
                    selected: [Translations.translateEnum('text${preferences.currency}')],
                     onSave: (res){
                      setState(() {
                        preferences.currency = Currency.all[options.indexOf(res.first)];             
                        update();
                      });
                    }
                  );
                }
              ),         
              buildSetting(Translations.time, 
                Row(
                  children: <Widget>[
                    Text(Translations.hour12,
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
                          update();
                        });
                      },
                    ),
                    Text(Translations.hour24,
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