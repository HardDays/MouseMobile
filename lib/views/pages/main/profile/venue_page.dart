import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';
import '../../../widgets/event_card.dart';
import '../../../widgets/followers_buttons.dart';

import 'widgets/account_header.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';

class VenuePage extends StatefulWidget {

  Account account;

  VenuePage({this.account});

  VenuePageState createState() => VenuePageState();
}

class VenuePageState extends State<VenuePage> with SingleTickerProviderStateMixin {
  
  bool showsLoaded = false;
  bool showInfo = false;

  Account account;

  TabController tabController;

  @override
  void initState(){
    super.initState();

    account = widget.account;

    tabController = TabController(length: 2, vsync: this);

    if (!showsLoaded){
      DataProvider.getUpcomingEvents(account.id).then(
        (res){
          setState(() {
            showsLoaded = true;
            account.upcomingShows = res.result;          
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
          child: Text(Translations.upcomingShows.toUpperCase(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontFamily: 'Avenir-Book', 
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
          child: Text(Translations.noMedia,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontFamily: 'Avenir-Book', 
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
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.9 - 50.0,     
                            child: YoutubeImage(
                              link: account.videos[ind].link,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.9 - 50.0,
                            )
                          )
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9 - 20.0,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                          child: Text(account.videos[ind].name ?? Translations.unnamed,
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
                          child: Text(account.videos[ind].albumName ?? Translations.unnamed,
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.width * 0.9,     
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
            //width: MediaQuery.of(context).size.width * 0.5,
            child: ExpansionTile(
              onExpansionChanged: (val){
                setState(() {
                  showInfo = val;                  
                });
              },
              trailing: Container(
                width: 0.0,
                height: 0.0,
              ),
              title: Row(
                children: <Widget>[
                  Text(Translations.contactInfo.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Book', 
                      fontSize: 14.0
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(showInfo ? 'assets/images/main/profile/expainsion_up_icon.png' : 'assets/images/main/profile/expansion_icon.png')
                      )
                    ),
                  )
                ]
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    children: [
                      account.phone != null ? 
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text('${Translations.phone}: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Avenir-Medium', 
                                fontSize: 14.0
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text(account.phone,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Avenir-Book', 
                                fontSize: 14.0
                              ),
                            ),
                          )
                        ]
                      ) : 
                      Container(),

                      account.fax != null ? 
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text('${Translations.fax}: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir-Medium', 
                                  fontSize: 14.0
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Text(account.fax,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir-Book', 
                                  fontSize: 14.0
                                ),
                              ),
                            )
                          ]
                        )
                      ) : 
                      Container(),
                      Column(
                        children: List.generate(account.emails.length, 
                          (ind) {
                            return Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  //width: MediaQuery.of(context).size.width * 0.4,
                                  child: Text('${account.emails[ind].name}: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir-Medium', 
                                      fontSize: 14.0
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 10.0),
                                  child: Text(account.emails[ind].email,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir-Book', 
                                      fontSize: 14.0
                                    ),
                                  ),
                                )
                              ]
                            );
                          }
                        )
                      ),
                      account.address != null ?
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            width: 20.0, 
                            height: 20.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/common/pin.png')
                              )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(account.address ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Avenir-Book', 
                                height: 16.0 / 14.0,
                                fontSize: 14.0
                              )
                            )
                          ),                
                        ],
                      ) : 
                      Container(),
                      Padding(padding: EdgeInsets.only(bottom: 20.0),)
                    ]
                  )
                )
              ],
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Dialogs.showHoursDialog(context, title: Translations.officeHours.toUpperCase(), hours: account.officeHours);
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2.0)
                      )
                    ),
                    child: Text(Translations.officeHours.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Avenir-Black', 
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Dialogs.showHoursDialog(context, title: Translations.operatingHours.toUpperCase(), hours: account.operatingHours);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    padding: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2.0)
                      )
                    ),
                    child: Text(Translations.operatingHours.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Avenir-Black', 
                      ),
                    )
                  )
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 20.0),
            child: FollowersButton(account: account)
          ),
          Container(
             margin: EdgeInsets.only(top: 20.0),
             color: AppColors.appBar,
             child: TabBar(
               indicatorColor: Colors.white,
               controller: tabController,
               tabs: <Widget>[
                 Container(
                   margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                   child: Text(Translations.upcomingShows.toUpperCase(),
                     style: TextStyle(
                       color: Colors.white,
                       fontFamily: 'Avenir-Heavy',
                       fontSize: 13.0 
                     ),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                   child: Text(Translations.media.toUpperCase(),
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