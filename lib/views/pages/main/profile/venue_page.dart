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
import '../../../widgets/event_list.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/storage/cache.dart';

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
      MainAPI.upcomingShows(account.id).then(
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
                          child: Text(account.videos[ind].name ?? 'Unnamed',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
                              fontWeight: FontWeight.w400,
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
          Stack(
            children: <Widget>[
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/main/profile/account_header.png')
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
                width: 100.0,
                height: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: AccountImage(account: account)
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 110.0, right: 15.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 30.0,
                  child: FollowButton()
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70.0, right: 15.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/main/profile/venue_icon.png')
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Text('VENUE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                )
              ),
            ]
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
            child: Text(account.displayName ?? 'Unnamed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Text('@',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.mainRed,
                    fontSize: 16.0
                  ),
                ),
                Text(account.userName ?? '',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),

          account.description != null ? 
          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
            child: Text(account.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400
              ),
            ),
          ) : 
          Container(),

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
                  Text('CONTACT INFO',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0
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
                            child: Text('Phone: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
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
                                fontWeight: FontWeight.w400,
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
                              child: Text('Fax: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
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
                                  fontWeight: FontWeight.w400,
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
                                      fontWeight: FontWeight.w500,
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
                                      fontWeight: FontWeight.w400,
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
                                fontWeight: FontWeight.w400,
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
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3.0)
                    )
                  ),
                  child: Text('OFFICE HOURS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  padding: EdgeInsets.only(bottom: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3.0)
                    )
                  ),
                  child: Text('OPERATING HOURS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 25.0),
            child: Row(
              children: <Widget>[ 
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Text('${account.followersCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      Text('Followers',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0
                        ),
                      )
                    ],
                  )
                ),
                Padding(padding: EdgeInsets.only(left: 25.0)),
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Text('${account.followingCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      Text('Following',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0
                        ),
                      )
                    ],
                  )
                )
              ],
            )
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
                   child: Text('UPCOMING SHOWS',
                     style: TextStyle(
                       color: Colors.white
                     ),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                   child: Text('MEDIA',
                     style: TextStyle(
                       color: Colors.white
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