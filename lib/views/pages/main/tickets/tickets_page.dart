import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'ticket_page.dart';

import 'widgets/ticket_header.dart';

import '../../start/start_page.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/default_image.dart';

import '../../../dialogs/dialogs.dart';
import '../../../dialogs/genres_filter_dialog.dart';
import '../../../dialogs/location_filter_dialog.dart';
import '../../../dialogs/other_filter_dialog.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/ticket.dart';
import '../../../../models/api/event.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/storage/filters/shows_filter.dart';
import '../../../../helpers/view/formatter.dart';

class TicketsPage extends StatefulWidget  {

   String get title => Translations.tickets.toUpperCase();
  final String icon = 'assets/images/main/tickets_tab_icon.svg';

  Function onBuildAppBar;
  Function onAppBarUpdate;

  Widget buildAppBar(){
    if (onBuildAppBar != null){
      return onBuildAppBar();
    }
  }

  TicketsPage();

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends State<TicketsPage> with SingleTickerProviderStateMixin {

  bool showFilters = false;

  TabController tabController;
  
  EventsFilter filter; 

  @override
  void initState() {
    super.initState();

    widget.onBuildAppBar = buildAppBar;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (context != null){
          if (DataProvider.isAuthorized()){
            DataProvider.getFanTickets(time: TicketTime.current, filter: filter).then((res){
              if (mounted){
                setState(() { });
              }
            });

            DataProvider.getFanTickets(time: TicketTime.past, filter: filter).then((res){
              if (mounted){
                setState(() { });
              }
            });

            widget.onAppBarUpdate();
          }
        }
      }
    );
    
    tabController = TabController(length: 2, vsync: this);

    filter = DataProvider.getTicketsFilter();
    
    tabController.addListener((){setState(() {});});
  }

  void showCalendar()  {
    Dialogs.showDatesFilterDialog(context, filter: filter.datesFilter, onSave: (dates) {
      setState(() {
        filter.datesFilter = dates;  
        DataProvider.setTicketsFilter(filter);
        update();         
      });
    });
  }
  
  void showGenres(){
    Dialogs.showGenresFilterDialog(context, filter: filter.genresFilter, onSave: (genres) {
      setState(() {
        filter.genresFilter = genres;  
        DataProvider.setTicketsFilter(filter);
        update();            
      });
    });
  }

  void showLocation(){
    Dialogs.showLocationFilterDialog(context, filter: filter.locationFilter, onSave: (loc) {
      setState(() {
        filter.locationFilter = loc;  
        DataProvider.setTicketsFilter(filter);
        update();          
      });
    });
  }

  void showOther(){
    Dialogs.showOtherFilterDialog(context, filter: filter.otherFilter, onSave: (other) {
      setState(() {
        filter.otherFilter = other;  
        DataProvider.setTicketsFilter(filter);
        update();      
      });
    });
  }

  void update(){
    DataProvider.flushFanTickets(time: TicketTime.current);
    DataProvider.flushFanTickets(time: TicketTime.past);
    DataProvider.getFanTickets(time: TicketTime.current, filter: filter).then((res){
      setState(() { });
    });

    DataProvider.getFanTickets(time: TicketTime.past, filter: filter).then((res){
      setState(() { });
    });
  }

  Widget buildEvents(List<Event> events){
    if (events.isEmpty){
      return Expanded(
        child: Container(
        //height: MediaQuery.of(context).size.height,
        //width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text('No tickets',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w300
            ),
          )
        ),       
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 160 - (showFilters ? 55 : 0),
        child: ListView(
          children: List.generate(events.length, 
            (ind) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    this.context,
                    DefaultPageRoute(builder: (context) => TicketPage(event: events[ind])),
                  );  
                },
                child: TicketHeader(event: events[ind])
              );
            }
          )
        )
      );
    }
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
            // IconButton(
            //   icon: Icon(Icons.search, color: Colors.white),
            //   onPressed: () {    
            //     /*Navigator.push(
            //       this.context,
            //       DefaultPageRoute(builder: (context) => SearchPage()),
            //     );*/               
            //   }
            // ),
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
    if (DataProvider.getCachedFanTickets(time: TicketTime.current) == null || DataProvider.getCachedFanTickets(time: TicketTime.past) == null){
    //if (pastEvents == null || upcomingEvents == null) {
      return Container(
        color: AppColors.mainBg,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else {
      return Container(
        color: AppColors.mainBg,
        child: Container(
          child: Column(
            children: <Widget>[
              buildFilters(),
              Container(
                margin: EdgeInsets.only(top: 0.0),
                color: AppColors.appBar,
                child: TabBar(
                  indicatorColor: Colors.white,
                  controller: tabController,
                  tabs: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(Translations.upcoming.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white, 
                          fontFamily: tabController.index == 0 ? 'Avenir-Black' : 'Avenir-Medium',
                          fontSize: 16.0 
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(Translations.past.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: tabController.index == 1 ? 'Avenir-Black' : 'Avenir-Medium',
                          fontSize: 16.0 
                        ),
                      ),
                    ) ,
                  ],
                )
              ),
              tabController.index == 0 ? 
              buildEvents(DataProvider.getCachedFanTickets(time: TicketTime.current)) : 
              buildEvents(DataProvider.getCachedFanTickets(time: TicketTime.past))
            ]
          ),
        ),
      );
    }
  }
}