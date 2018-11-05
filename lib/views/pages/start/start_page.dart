import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';  

import 'login_page.dart';
import 'create_user_page.dart';

import 'widgets/bottom_login_widget.dart';

import '../../widgets/shadow_text.dart';
import '../../widgets/main_button.dart';

import '../../routes/default_page_route.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/translations.dart';

class StartPage extends StatefulWidget {

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  List <String> bgImages = ['assets/images/start/start1_bg.png', 'assets/images/start/start2_bg.png', 'assets/images/start/start3_bg.png'];
  List <String> texts = [Translations.campaingToBring.toUpperCase(), Translations.watchLiveShows.toUpperCase(), Translations.discoverMusic.toUpperCase()];

  TabController tabController;

  @override
  void initState() {    
    super.initState();
    
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          TabBarView(
            controller: tabController,
            children: List.generate(tabController.length, 
              (ind) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width, 
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(bgImages[ind]),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(AppColors.startScreenFill, BlendMode.difference)
                        )
                      ), 
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width, 
                      height: MediaQuery.of(context).size.height,
                      color: AppColors.startScreenFill,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.165),
                          width: MediaQuery.of(context).size.width, 
                          height: MediaQuery.of(context).size.height * 0.4,
                          alignment: Alignment.center,
                          child: Text(texts[ind],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 34.0
                            ),
                          )
                        )
                      ],
                    )
                  ]
                );
              }
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 40.0),
            width: MediaQuery.of(context).size.width, 
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  width: 40.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/start/mouse_logo.png')
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TabPageSelector(
                    controller: tabController,
                    selectedColor: AppColors.mainRed,
                    color: Colors.transparent
                  )
                ),
              ]
            )
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.64),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: 50.0,
                        child: MainButton(Translations.login.toUpperCase(),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.purpleGradButton,
                              AppColors.purpleGradButton
                            ]
                          ),
                          onTap: (){
                            Navigator.push(
                              this.context,
                              DefaultPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: 50.0,
                        child: MainButton(Translations.signUp.toUpperCase(),
                          onTap: (){
                            Navigator.push(
                              this.context,
                              DefaultPageRoute(builder: (context) => CreateUserPage()),
                            );
                          },
                        ),
                      )
                    ],
                  )
                ),
                BottomLoginWidget()
              ]
            )
          )
        ]
      )
    );
  }
}
