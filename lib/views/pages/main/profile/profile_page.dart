import 'package:flutter/material.dart';

import 'settings/settings_page.dart';

import 'widgets/account_header.dart';

import '../../start/start_page.dart';

import '../../../dialogs/dialogs.dart';

import '../../../widgets/follow_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';
import '../../../widgets/followers_buttons.dart';
import '../../../widgets/main_button.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';

class ProfilePage extends StatefulWidget  {

  String title = Translations.profile.toUpperCase();
  String icon = 'assets/images/main/profile_tab_icon.svg';

  TabController bottomController;

  Widget appBar;
  Function(Widget) onLoad;

  ProfilePage({this.bottomController});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  
  Account account;
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    tabController.addListener((){
      setState(() { });
    });

    account = DataProvider.getCachedCurrentAccount();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context != null){
        if (DataProvider.isAuthorized()){
          DataProvider.getCurrentAccount().then(
            (res){
              if (res.status == DataStatus.ok){
                if (mounted){
                  setState(() {
                    account = res.result;
                  });
                }
              }
            }
          );
          buildAppBar(context);
        } 
      }
    });
  }

  void buildAppBar(BuildContext context){
    widget.appBar = PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              width: 25.0,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(                               
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/start/mouse_logo.png'),
                  ),
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(left: 10.0)),
            Text(widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Avenir-Black', 
              ),
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {   
              DataProvider.flush();
              //Database.deleteCurrentAccount();
              //Database.deleteCurrentUser();
              Navigator.pushReplacement(
                context, 
                DefaultPageRoute(builder: (context) => StartPage()),
              );              
            }
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {   
              //Database.deleteCurrentAccount();
              //Database.deleteCurrentUser();
              Navigator.push(
                context, 
                DefaultPageRoute(builder: (context) => SettingsPage()),
              );              
            }
          )
        ]
      )
    );
    widget.onLoad(widget.appBar);
  } 

  Widget buildRewards(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Text(Translations.noRewards,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
            fontFamily: 'Avenir-Book', 
          ),
        )
      ),
    ); 
  }

  Widget buildFavorites(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Text(Translations.noFavorites,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
            fontFamily: 'Avenir-Book', 
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
        child: Text(Translations.noCampaigns,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
            fontFamily: 'Avenir-Book', 
          ),
        )
      ),
    ); 
  }

  @override 
  Widget build(BuildContext ctx) {
    widget.title = Translations.profile.toUpperCase();
    //buildAppBar(context);
    if (DataProvider.isAuthorized()){
      return Container(
        color: AppColors.mainBg,
        child: SingleChildScrollView(
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
                      child: Text(Translations.rewards.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Avenir-Heavy',
                          fontSize: 13.0 
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(Translations.favorites.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Avenir-Heavy',
                          fontSize: 13.0 
                        ),
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(Translations.campaigns.toUpperCase(),
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
              tabController.index == 0 ? 
              buildRewards() : (tabController.index == 1 ? buildFavorites() : buildCampaigns())
            ],
          ),
        )
      );
    } else {
      return Container(
        color: AppColors.mainBg,
        child: SingleChildScrollView(
          
        ),
      );
    }
  }
}