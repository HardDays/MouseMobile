import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'search_page.dart';
import 'player_page.dart';
import 'ticket_page.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/event_card.dart';

import '../../../dialogs/dialogs.dart';
import '../../../dialogs/genres_filter_dialog.dart';
import '../../../dialogs/location_filter_dialog.dart';
import '../../../dialogs/other_filter_dialog.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/event.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/storage/filters/shows_filter.dart';
import '../../../../helpers/view/formatter.dart';

import '../../../widgets/default_image.dart';

class ContentPage extends StatefulWidget  {

  String get title => Translations.shows.toUpperCase();
  final String icon = 'assets/images/main/shows_tab_icon.svg';

  Function onBuildAppBar;
  Function onAppBarUpdate;

  Widget buildAppBar(){
    if (onBuildAppBar != null){
      return onBuildAppBar();
    }
  }

  @override
  ContentPageState createState() => ContentPageState();
}

class ContentPageState extends State<ContentPage> with AutomaticKeepAliveClientMixin {

  bool showFilters = false;
  
  List<Event> events;
  
  EventsFilter filter;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    events = [];

    DefaultAssetBundle.of(context).loadString("assets/content.json").then((data){
      var jsonResult = json.decode(data);
      for (var res in jsonResult){
        events.add(
          Event(
            name: res['title'],
            tickets: [],
            link: res['kassir'],
            isCrowdfunding: false,
            address: res['venue']['address'],
            description: res['image'],
            dateFrom: DateTime.parse(res['exacted_date'])
          )
        );
        setState(() {
                  
        });
      }
    });
  }

  @override 
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: PreferredSize( 
        preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          title: Row(
            children:[
              Padding(padding: EdgeInsets.only(left: 10.0)),
              Text('Content',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Avenir-Black', 
                // fontStyle: FontStyle.italic
                ),
              )
            ]
          ),
          backgroundColor: AppColors.appBar,
          actions: [
           
          ]
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 110 - (showFilters ? 55 : 0),
              child: ListView(
                children: List.generate(events.length, 
                  (ind){
                      bool isPromo = false;
                      var event = events[ind];
                      for (var tk in event.tickets){
                        if (tk.isPromotional){
                          isPromo = true;
                        }
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 10.0, left: 7.0, right: 7.0),
                        decoration: BoxDecoration(
                          color: AppColors.showCard,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(50.0),
                          )
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: GestureDetector( 
                          onTap: () {
                            
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width - 70.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 100),
                                    imageUrl: event.description ?? '',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    errorWidget:  Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/common/empty_account.png')
                                        )
                                      )
                                    ),
                                    placeholder: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/common/empty_account.png')
                                        )
                                      )
                                    ),
                                  ) 
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0.0),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width - 20.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(25.0),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.showCard.withOpacity(0.2),
                                      AppColors.showCard.withOpacity(1.0)
                                    ]
                                  )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width - 70.0,
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        event.dateFrom != null ?
                                        Container(
                                          margin: EdgeInsets.only(right: 10.0),
                                          height: 75.0,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 26.0,
                                                child: Text(
                                                  event.dateFrom.month.toString().padLeft(2, '0'),
                                                  style: TextStyle(
                                                    color: AppColors.textRed,
                                                    fontFamily: 'Avenir-Black',
                                                    fontSize: 27.0
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 30.0,
                                                child: Text(
                                                  event.dateFrom.day.toString().padLeft(2, '0'),
                                                  style: TextStyle(
                                                    color: AppColors.textRed,
                                                    fontFamily: 'Avenir-Black',
                                                    fontSize: 27.0
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 17.0,
                                                child: Text(event.dateFrom.year.toString(),
                                                  style: TextStyle(
                                                    color: AppColors.textRed,
                                                    fontFamily: 'Avenir-Black',
                                                    fontSize: 12.0
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ) :
                                        Container(),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              event.isCrowdfunding ? 
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text('${(100 * min(event.founded / max(1.0, event.fundingGoal), 1.0)).floor()}% ${Translations.funded}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontFamily: 'Montserrat-Regular'
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.6 * min(event.founded / max(1.0, event.fundingGoal), 1.0),
                                                      height: 5.0,
                                                      color: AppColors.promoBg,
                                                    )
                                                  ],
                                                ),
                                              ) :
                                              isPromo ? Container(
                                                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                                                color: AppColors.promoBg,
                                                child: Text(Translations.promo.toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat-SemiBold',
                                                    color: Colors.black,
                                                    fontSize: 13.0
                                                  ),
                                                ),
                                              ) : 
                                              Container(),                            
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                //margin: EdgeInsets.only(bottom: !isPromo && !event.isCrowdfunding ? 10.0 : 0.0),
                                                child: Text(event.name.toUpperCase(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontFamily: 'Avenir-Black',
                                                    color: Colors.white
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                child: Text(event.venue != null ? (event.venue?.displayName  ?? '' + ' - ' + event.venue.address ?? '') : event.address,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: 'AvenirNext-Medium',
                                                    color: Colors.white
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.11,
                                        height: MediaQuery.of(context).size.width * 0.11,
                                        margin: EdgeInsets.only(bottom: 15.0, right: 15.0),
                                        alignment: Alignment.bottomRight,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/main/shows/play_button.png')
                                          )
                                        ),
                                      )
                                    )
                                  ]  
                                )
                              ),
                              Container(
                                height: 70.0,
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.width - 70.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    event.tickets.isNotEmpty ? 
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      margin: EdgeInsets.only(right: 15.0),
                                      alignment: Alignment.centerRight,
                                      child: Text('${Translations.startingFrom} ${Translations.translateEnum(event.tickets[0].currency)}${event.tickets[0].price.floor()}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontFamily: 'Montserrat-Light',
                                        ),
                                      ),
                                    ) :
                                    Container(),
                                    Container(
                                      margin: EdgeInsets.only(right: 15.0),
                                      //width: MediaQuery.of(context).size.width * 0.4,
                                      height: 36.0,
                                      child: MainButton(Translations.buyTicket.toUpperCase(),
                                      onTap: () {    
                                        Navigator.push(
                                          this.context,
                                          DefaultPageRoute(builder: (context) => new TicketPage(url: event.link)),
                                        );               
                                      }
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      );
                  }
                )
              )
            )
          ]
        ),
      )
    );
  }
}