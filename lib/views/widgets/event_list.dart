import 'package:flutter/material.dart';

import 'event_card.dart';

import '../../models/api/event.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/storage/cache.dart';

class EventListController {
  String text;

  Function() _onTextChange;

  EventListController({this.text});

  void setText(String text){
    this.text = text;
    _onTextChange();
  }
}

class EventList extends StatefulWidget {
  
  EventListController controller;

  EventList({this.controller});
  @override
  EventListState  createState() =>  EventListState();
}

class EventListState extends State<EventList> with AutomaticKeepAliveClientMixin {

  List <Event> events;

  @override
  void initState() {
    super.initState();

    if (events == null){
      update();
    }

    widget.controller?._onTextChange = updateText;
  }

  @override
  bool get wantKeepAlive => true;

  void update() {
    MainAPI.searchEvents(text: widget.controller?.text).then(
      (events){
        setState(() {
          this.events = events;
        });
      }
    );
  }

  void updateText() {
    setState(() {
      events = null;          
    });
    update();
  }
  
  Widget build(BuildContext context) {
    if (events == null){
      return Container(
        color: AppColors.mainBg,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else if (events.isEmpty){
      return Container(
        color: AppColors.mainBg,
        child: Center(
          child: Text('No shows found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w300
            ),
          ), 
        ),        
      );
    } else {
      return Container(
        color: AppColors.mainBg,
        child: ListView(
          children: List.generate(events.length, 
            (ind) {
              return EventCard(event: events[ind]);
            }
          )
        )
      );
    }
  }
}