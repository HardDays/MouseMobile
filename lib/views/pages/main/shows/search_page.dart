import 'dart:async';

import "package:google_maps_webservice/places.dart";
import 'package:flutter/material.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_list.dart';
import '../../../widgets/event_list.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/storage/cache.dart';

class SearchPage extends StatefulWidget {
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  
  int index = 0;
  bool showSearch = false;

  String text;

  TabController tabController;

  EventListController eventController;
  List<AccountListController> accountsControllers;

  List <Widget> pages;

 // List <Event> shows;
  //List <List<Account>> accounts = [null, null, null];

  @override
  void initState(){
    super.initState();

    eventController = EventListController();
    accountsControllers = [
      AccountListController(accountType: AccountType.fan),
      AccountListController(accountType: AccountType.artist),
      AccountListController(accountType: AccountType.venue)
    ];

    pages = [
      EventList(controller: eventController),
      AccountList(controller: accountsControllers[0]), 
      AccountList(controller: accountsControllers[1]), 
      AccountList(controller: accountsControllers[2])
    ];

    tabController = TabController(length: 4, initialIndex: 0, vsync: this);
  }

/*
  void loadShows(){
    MainAPI.searchEvents().then((shows){
      setState(() {
       // this.shows = shows;        
      });
    });
  }*/

/*
  void loadAccounts(){
    List <String> accs = [AccountType.fan, AccountType.artist, AccountType.venue];
    MainAPI.searchAccounts(accountType: accs[index - 1]).then((accounts){
      setState(() {
        //this.accounts[index - 1] = accounts;        
      });
    });
  }*/

  void update(){
    setState(
      () {
        showSearch = false;
        if (index == 0){
          eventController.setText(text);
        }else{
          accountsControllers[index - 1].setText(text);          
        }   
        FocusScope.of(context).requestFocus(FocusNode());
      }
    );
  }

  Widget buildTabs(){
    List <String> titles = ['SHOWS', 'FANS', 'ARTISTS', 'VENUES'];
    return Container(
      height: 55.0,
      alignment: Alignment.center,
      color: AppColors.appBar,
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 5.0, right: 5.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(titles.length, 
          (ind){
            return Container(
              margin: EdgeInsets.only(right: 3.0, left: 3.0),
              height: 30.0,
              child: MainTagbox(titles[ind],
                checked: ind == index,
                onTap: (){
                  setState(() {
                    index = ind;     
                    tabController.index = index;            
                  });
                },
                checkedGradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.6),
                    Colors.grey.withOpacity(0.6)
                  ]
                ),
                uncheckedGradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent
                  ]
                ),
              ),
            );
          }
        )                 
      ),
    );
  }

  //Widget buildContent(){
    // /*if (index == 0){
    //   if (shows == null){
    //     loadShows();
    //     return buildLoading();
    //   } else {
    //     return Expanded(
    //       child: Container(
    //         color: AppColors.mainBg,
    //         child: ListView(
    //           children: List.generate(shows.length, 
    //             (ind) {
    //               return EventCard(event: shows[ind]);
    //             }
    //           )
    //         )
    //       )
    //     );
    //   }
    // } else {

    //   return accountPages[2];

    //   /*
    //   if (accounts[index - 1] == null){
    //     loadAccounts();
    //     return buildLoading();
    //   } else {
    //     return Expanded(
    //       child: ListView(
    //         children: List.generate(accounts[index - 1].length, 
    //           (ind) {
    //             return AccountCard(account: accounts[index - 1][ind]);
    //           }
    //         )
    //       )
    //     );
    //   }*/
    // }
  //}

  @override 
  Widget build(BuildContext ctx) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize( 
        preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
        child: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.appBar,
          title: TextField(
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Avenir-Book', 
            ),
            decoration: InputDecoration.collapsed(
              hintText: 'Search',       
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(0.6),
                fontFamily: 'Avenir-Book', 
              )     
            ),
            onChanged: (value) {
              setState(() {
                showSearch = true;      
                text = value;          
              });
            },          
            onEditingComplete: () {       
              update();
            },
          ),    
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Divider(
                  color: Colors.black.withOpacity(0.8),
                  height: 0.5
                ),
                buildTabs(),
                Expanded(
                  //width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height - 126,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: pages
                  ),
                )
                //buildContent()
              ]
            ),
            showSearch ?
            Container(
              alignment: Alignment.center,
              height: 50.0,
              margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height - 130) - MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MainButton('SEARCH',
                  onTap: (){
                    update();
                  },
                ),  
              )
            ) : 
            Container(),
          ]
        )
      ),
    );
  }
}