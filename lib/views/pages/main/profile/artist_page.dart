  import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import 'widgets/account_header.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';
import '../../../widgets/event_card.dart';
import '../../../widgets/followers_buttons.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/storage/cache.dart';

class ArtistPage extends StatefulWidget {

  Account account;

  ArtistPage({this.account});

  ArtistPageState createState() => ArtistPageState();
}

class ArtistPageState extends State<ArtistPage> with SingleTickerProviderStateMixin {
  
  bool showsLoaded = false;

  Account account;

  TabController tabController;

  @override
  void initState(){
    super.initState();

    account = widget.account;

    tabController = TabController(length: 2, vsync: this);

    if (!showsLoaded){
      MainAPI.getUpcomingShows(account.id).then(
        (res){
          setState(() {
            showsLoaded = true;
            account.upcomingShows = res;          
          });
        }
      );
    }

    tabController.addListener(
      () {
        setState(() {});
      }
    );
  }

  Widget buildUpcoming(){
    if (account.upcomingShows.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text('No upcoming shows',
            style: TextStyle(
              fontFamily: 'Avenir-Book', 
              color: Colors.grey,
              fontSize: 18.0
            ),
          )
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: List.generate(account.upcomingShows.length, 
            (ind) {
              return EventCard(event: account.upcomingShows[ind]);
            }
          )
        )
      );
    }
  }

  Widget buildMedia(){
    if (account.videos.isEmpty && account.images.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text('No media',
            style: TextStyle(
              fontFamily: 'Avenir-Book', 
              color: Colors.grey,
              fontSize: 18.0
            ),
          )
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          account.videos.isNotEmpty ? 
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(account.videos.length, 
                (ind) {
                  return Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 20.0),
                    decoration: BoxDecoration(
                      color: AppColors.mediaBg,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                          child: Container( 
                            alignment: Alignment.topCenter,
                            width: account.videos.length > 1 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width - 20.0,
                            height: MediaQuery.of(context).size.width * 0.9 - 50.0,     
                            child: YoutubeImage(
                              link: account.videos[ind].link,
                              width: account.videos.length > 1 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width - 20.0,
                              height: MediaQuery.of(context).size.width * 0.9 - 50.0,
                            )
                          )
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9 - 20.0,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                          child: Text(account.videos[ind].name ?? 'Unnamed',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir-Black', 
                              fontSize: 16.0
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9 - 20.0,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                          child: Text(account.videos[ind].albumName ?? 'Unnamed',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir-Book', 
                              fontSize: 16.0
                            ),
                          ),
                        )
                      ]
                    )
                  );
                }
              ),
            ),
          ) : 
          Container(),

          account.images.isNotEmpty ? 
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.9,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(account.images.length, 
                (ind) {
                  return Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 20.0, bottom: 20.0), 
                    decoration: BoxDecoration(
                      color: AppColors.mediaBg,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: Container( 
                        width: account.images.length > 1 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width - 20.0,
                        height: account.images.length > 1 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width - 20.0,     
                        child: DefaultImage(
                          id: account.images[ind].id,
                        )
                      )                            
                    ),    
                  );
                }
              ),
            ),
          ) : 
          Container()
        ],
      );
    }
  }

  @override 
  Widget build(BuildContext ctx) {
    return SingleChildScrollView(
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
                   child: Text('UPCOMING SHOWS',
                     style: TextStyle(
                       color: Colors.white,
                       fontFamily: 'Avenir-Heavy',
                       fontSize: 13.0 
                     ),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                   child: Text('MEDIA',
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
           tabController.index == 0 ? buildUpcoming() : buildMedia()
        ],
      ),
    );
  }
}