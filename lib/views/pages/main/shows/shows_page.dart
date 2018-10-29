import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/main_checkbox.dart';

import '../../../dialogs/dialogs.dart';
import '../../../dialogs/genres_filter_dialog.dart';
import '../../../dialogs/location_filter_dialog.dart';
import '../../../dialogs/other_filter_dialog.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/genre.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/storage/cache.dart';
import '../../../../helpers/storage/filters/shows_filter.dart';

class ShowsPage extends StatefulWidget  {

  final String title = Translations.showsCaps;
  final String icon = 'assets/images/main/shows_tab_icon.svg';

  Widget appBar;
  Function(Widget) onLoad;

  @override
  ShowsPageState createState() => ShowsPageState();
}

class ShowsPageState extends State<ShowsPage> {

  bool showFilters = false;
  
  ShowsFilter filter;

  @override
  void initState() {
    super.initState();

    filter = Cache.showsFilter;

    if (Cache.events == null){
      Cache.events = [];
      /*MainAPI.searchEvents().then(
        (res){
          setState(() {
            Cache.events = res;            
          });
        }
      );*/
    }
    
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (context != null){
          buildAppBar(context);
        }
      }
    );
  }

  void showCalendar()  {
    Dialogs.showCalendarFilterDialog(context, startDate: filter.datesFilter.dateFrom, endDate: filter.datesFilter.dateTo, onSave: (dates){
      setState(() {
        Cache.showsFilter.datesFilter = dates;            
      });
    });
  }
  
  void showGenres(){
    Dialogs.showGenresFilterDialog(context);
  }

  void showLocation(){
    Dialogs.showLocationFilterDialog(context);
  }

  void showOther(){
    Dialogs.showOtherFilterDialog(context);
  }


  void buildAppBar(BuildContext context){
    widget.appBar = PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 40.0),
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
                fontWeight: FontWeight.w500
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
          ),
          IconButton(
            icon: Container(
              width: 20.0,
              height: 20.0,
              child: SvgPicture.asset('assets/images/main/filters_icon.svg',
                color: showFilters ? AppColors.mainRed : Colors.white
              ),
            ),
            onPressed: () { 
              setState(() {
                showFilters = !showFilters;         
                buildAppBar(context);       
              });                  
            }
          )
        ]
      )
    );
    widget.onLoad(widget.appBar);
  } 

  @override 
  Widget build(BuildContext ctx){
    if (Cache.events == null){
      return Container(
        color: AppColors.mainBg,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else {
      return Container(
        color: AppColors.mainBg,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              showFilters ? Container(
                height: 60.0,
                alignment: Alignment.center,
                color: AppColors.appBar,
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 2.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 3.0, left: 3.0),
                      height: 30.0,
                      child: MainTagbox(filter.datesFilter.isNotEmpty ? 
                        '${DateFormat('dd.MM.yyyy').format(filter.datesFilter.dateFrom)} - ${DateFormat('dd.MM.yyyy').format(filter.datesFilter.dateTo)}' : 
                        'DATE',
                        checked: filter.datesFilter.isNotEmpty,
                        onTap: showCalendar,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 3.0, left: 3.0),
                      height: 30.0,
                      child: MainTagbox('GENRE',
                        checked: !filter.genresFilter.isEmpty,
                        onTap: showGenres,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 3.0, left: 3.0),
                      height: 30.0,
                      child: MainTagbox('LOCATION',
                        checked: !filter.locationFilter.isEmpty,
                        onTap: showLocation,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 3.0, left: 3.0),
                      height: 30.0,
                      child: MainTagbox('OTHER FILTERS',
                        checked: !filter.otherFilter.isEmpty,
                        onTap: showOther
                      ),
                    ),
                  ]                  
                ),
              ) : 
              Container(),
              Column(
                children: List.generate(Cache.events.length, 
                  (ind){
                    var event = Cache.events[ind];
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
                            child: CachedNetworkImage(  
                              fadeOutDuration: Duration(milliseconds: 100),
                              fadeInDuration: Duration(milliseconds: 100),
                              alignment: Alignment.topCenter,
                              fit: BoxFit.cover,
                              imageUrl: event.imageId != null ? MainAPI.getImageUrl(event.imageId) : 'https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02',
                              placeholder: Image(fit: BoxFit.cover, image: NetworkImage('https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02')),
                              errorWidget: Image(fit: BoxFit.cover, image: NetworkImage('https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02'))
                            ), //NetworkImage('https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02')
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
                                      height: 65.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            height: 26.0,
                                            child: Text(event.dateFrom.month.toString().padLeft(2, '0'),
                                              style: TextStyle(
                                                color: AppColors.textRed,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 27.0
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 26.0,
                                            child: Text(event.dateFrom.day.toString().padLeft(2, '0'),
                                              style: TextStyle(
                                                color: AppColors.textRed,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 27.0
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 13.0,
                                            child: Text(event.dateFrom.year.toString(),
                                              style: TextStyle(
                                                color: AppColors.textRed,
                                                fontWeight: FontWeight.w700,
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
                                                      fontWeight: FontWeight.w400
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
                                          Container(
                                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                                            color: AppColors.promoBg,
                                            child: Text(Translations.promoCaps,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 13.0
                                              ),
                                            ),
                                          ),                             
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Text(event.name.toUpperCase(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Text(event.venue != null ? (event.venue.displayName + ' - ' + event.venue.address) : event.address,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
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
                                  child: Text('${Translations.startingFrom} \$${event.tickets[0].price.floor()}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w200
                                    ),
                                  ),
                                ) :
                                Container(),
                                Container(
                                  margin: EdgeInsets.only(right: 15.0),
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 36.0,
                                  child: MainButton(Translations.buyTicketCaps),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                )
              )
            ]
          ),
        ),
      );
    }
  }
}