import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'search_page.dart';

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

class ShowsPage extends StatefulWidget  {

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
  ShowsPageState createState() => ShowsPageState();
}

class ShowsPageState extends State<ShowsPage> with AutomaticKeepAliveClientMixin {

  bool showFilters = false;
  
  List<Event> events;
  
  EventsFilter filter;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    widget.onBuildAppBar = buildAppBar;

    filter = DataProvider.getEventsFilter();

    DataProvider.getEvents(filter: filter, cached: true).then(
      (res){
        if (mounted){
          setState(() {                        
            events = res.result;
          });
        }
      }
    );
    
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (context != null){
          widget.onAppBarUpdate();
        }
      }
    );
  }

  void showCalendar()  {
    Dialogs.showDatesFilterDialog(context, filter: filter.datesFilter, onSave: (dates) {
      setState(() {
        filter.datesFilter = dates;  
        DataProvider.setEventsFilter(filter);
        update();         
      });
    });
  }
  
  void showGenres(){
    Dialogs.showGenresFilterDialog(context, filter: filter.genresFilter, onSave: (genres) {
      setState(() {
        filter.genresFilter = genres;  
        DataProvider.setEventsFilter(filter);
        update();            
      });
    });
  }

  void showLocation(){
    Dialogs.showLocationFilterDialog(context, filter: filter.locationFilter, onSave: (loc) {
      setState(() {
        filter.locationFilter = loc;  
        DataProvider.setEventsFilter(filter);
        update();          
      });
    });
  }

  void showOther(){
    Dialogs.showOtherFilterDialog(context, filter: filter.otherFilter, onSave: (other) {
      setState(() {
        filter.otherFilter = other;  
        DataProvider.setEventsFilter(filter);
        update();      
      });
    });
  }

  void update(){
    Dialogs.showLoader(context);
    DataProvider.getEvents(filter: filter, cached: true).then(
      (res){
        Navigator.pop(context);
        setState(() {
          events = res.result;            
        });
      }
    );
  }

  Widget buildAppBar(){
    if (context != null){
      return PreferredSize( 
        preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
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
                Navigator.push(
                  this.context,
                  DefaultPageRoute(builder: (context) => SearchPage()),
                );               
              }
            ),
            IconButton(
              icon: Container(
                width: 20.0,
                height: 20.0,
                child: SvgPicture.asset('assets/images/common/filters_icon.svg',
                  color: showFilters ? AppColors.mainRed : Colors.white
                ),
              ),
              onPressed: () { 
                setState(() {
                  showFilters = !showFilters;         
                  widget.onAppBarUpdate();
                });                  
              }
            )
          ]
        )
      );
    }
  } 

  Widget buildFilters(){
    return showFilters ? 
      Container(
        height: 55.0,
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
                '${Formatter.shortDate(filter.datesFilter.dateFrom)} - ${Formatter.shortDate(filter.datesFilter.dateTo)}' : 
                Translations.date.toUpperCase(),
                checked: filter.datesFilter.isNotEmpty,
                onTap: showCalendar,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 3.0, left: 3.0),
              height: 30.0,
              child: MainTagbox(filter.genresFilter.isNotEmpty ?
                '${Translations.genre.toUpperCase()} • ${filter.genresFilter.genres.length}':
                Translations.genre.toUpperCase(),
                checked: filter.genresFilter.isNotEmpty,
                onTap: showGenres,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 3.0, left: 3.0),
              height: 30.0,
              child: MainTagbox(filter.locationFilter.isNotEmpty ?
                '${filter.locationFilter.address}':
                Translations.location.toUpperCase(),
                checked: filter.locationFilter.isNotEmpty,
                onTap: showLocation,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 3.0, left: 3.0),
              height: 30.0,
              child: MainTagbox(filter.otherFilter.isNotEmpty ?
                '${Translations.otherFilters.toUpperCase()} • ${filter.otherFilter.ticketTypes.length + filter.otherFilter.venueTypes.length}':
                Translations.otherFilters.toUpperCase(),
                checked: filter.otherFilter.isNotEmpty,
                onTap: showOther
              ),
            ),
          ]                  
        ),
      ) : 
      Container();
  }

  @override 
  Widget build(BuildContext ctx) {
    if (events == null) {
      return Container(
        color: AppColors.mainBg,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else if (events.isEmpty) {
      return Container(
        color: AppColors.mainBg,
        child: Stack(
          children: <Widget>[
            buildFilters(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(Translations.noShowsFound,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300
                ),
              ),
            )
          ],        
        ),        
      );
    } else {
      return Container(
        color: AppColors.mainBg,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildFilters(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 110 - (showFilters ? 55 : 0),
                child: ListView(
                  children: List.generate(events.length, 
                    (ind){
                      return EventCard(event: events[ind]);
                    }
                  )
                )
              )
            ]
          ),
        ),
      );
    }
  }
}