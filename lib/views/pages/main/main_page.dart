import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'shows/shows_page.dart';

import 'profile/profile_page.dart';
import 'tickets/tickets_page.dart';
import 'feed/feed_page.dart';

import '../start/start_page.dart';

import '../../dialogs/dialogs.dart';

import '../../routes/default_page_route.dart';

import '../../../helpers/storage/data_provider.dart';
import '../../../resources/app_colors.dart';

import '../../../resources/translations.dart';


class MainPage extends StatefulWidget {

  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  TabController tabController;
  List pages;

  MainPageState(){

  }

  @override
  void initState() {
    super.initState();
        
    tabController = TabController(length: 4, vsync: this, initialIndex: 2);

    tabController.addListener(
      (){
        if (tabController.index != 2){
          if (!DataProvider.isAuthorized()){
            Dialogs.showYesNoDialog(context, 
              title: Translations.unauthorized, 
              body: Translations.pleaseLogin, 
              yes: Translations.yes, 
              no: Translations.no, 
              onYes: (){
                Navigator.pushReplacement(
                  this.context,
                  DefaultPageRoute(builder: (context) => StartPage()),
                );
              }, 
              onNo: (){
                setState(() {
                  tabController.index = 2;
                });
              }
            );
          }
        }
      }
    );

    pages = [TicketsPage(bottomController: tabController), FeedPage(bottomController: tabController), ShowsPage(), ProfilePage(bottomController: tabController)];
    for (var page in pages){
      page.onLoad = onAppBarLoad;
    }

  }
  
  void onAppBarLoad(Widget appbar){
    setState(() {
          
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
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
            Text(pages[tabController.index].title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Avenir-Black'
               // fontStyle: FontStyle.italic
              ),
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {   
                         
            }
           )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: pages[tabController.index].appBar ?? buildAppBar(),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: List<Widget>.from(pages),
        controller: tabController,
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 45.0,
        child: Column(
          children: [
            Row(            
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(tabController.length, 
                (ind) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        tabController.index = ind;                          
                      });
                    },
                    child: Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width / 5.0,
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 3.0)),
                          /*Icon(Icons.crop_square,
                            color: tabController.index == ind ? AppColors.mainRed : Colors.white,
                          ),*/
                          Container(
                            width: 20.0,
                            height: 20.0,
                            child: SvgPicture.asset(pages[ind].icon,
                              color: tabController.index == ind ? AppColors.mainRed : Colors.white,
                            )
                          ),
                          Padding(padding: EdgeInsets.only(top: 2.0)),
                          Text(pages[ind].title,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Avenir-Medium',
                              color: tabController.index == ind ? AppColors.mainRed : Colors.white,
                              fontSize: 9.0
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 2.0)),
                          Container(
                            alignment: Alignment.center,
                            color: tabController.index == ind ? AppColors.mainRed : Colors.transparent,
                            height: 1.0,
                            width: MediaQuery.of(context).size.width / 10.0,
                          )
                        ],
                      ),
                    )
                  );
                }
              ),        
              //controller: tabController,
            ), 
          ]      
        ),
      ),
    );
  }
}

