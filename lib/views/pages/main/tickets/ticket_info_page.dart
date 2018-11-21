import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/view/formatter.dart';

class TicketInfoPage extends StatefulWidget {

  Event event;

  Ticket ticket;

  TicketInfoPage({this.event, this.ticket});

  TicketInfoPageState createState() => TicketInfoPageState();
}

class TicketInfoPageState extends State<TicketInfoPage> {

  @override
  void initState() { 
    super.initState();
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Row(
          children:[
            Text(Translations.ticket.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w700
              // fontStyle: FontStyle.italic
              ),
            )
          ]
        ),
        backgroundColor: AppColors.appBar
      )
    );
  }

  @override 
  Widget build(BuildContext ctx) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.mainBg,
      appBar: buildAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/images/main/shows/check_form.png')
            )
          ),
          child: Container(
            padding: EdgeInsets.only(left: 0.0, top: 40.0, right: 0.0, bottom: 40.0),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                //color: Colors.green,
                child: Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 30.0, top: 0.0, right: 30.0),
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height * 0.33,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: Text(widget.event.name.toUpperCase(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontFamily: 'Avenir-Black', 
                                      ),
                                    ),
                                  ),
                                ]
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Text(Translations.translateEnum(widget.ticket.type) + ' ${Translations.ticket.toLowerCase()}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Avenir-Book', 
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Text(widget.ticket.isPersonal ? '(${Translations.special})' : '(${Translations.regular})',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Avenir-Book', 
                                ),
                              ),     
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Container(
                                child: Text((widget.event?.venue?.displayName ?? '') + ' ' + (widget?.event?.venue?.address ?? ''), 
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'Avenir-Book', 
                                  ),
                                ),
                              ),
                              widget.event.dateFrom != null ? 
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('${Formatter.longDate(widget.event.dateFrom)},',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir-Medium', 
                                        fontSize: 14.0
                                      )
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 2.0)),
                                    Text('${Formatter.time(widget.event.dateFrom)}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir-Medium', 
                                        fontSize: 14.0
                                      )
                                    ),
                                  ],
                                ),
                              ) : 
                              Container(),                                                               
                              Container(
                                margin: EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
                                child: Divider(color: Colors.black.withOpacity(0.3), height: 2.0),
                              ),  
                              Container(
                                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('${Translations.total}: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir-Book', 
                                        fontSize: 16.0
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5.0)),
                                    Text('${Translations.translateEnum(widget.ticket.currency)}${widget.ticket.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir-Heavy', 
                                        fontSize: 16.0
                                      ),
                                    ),
                                  ]
                                )
                              ),
                              Padding(padding: EdgeInsets.only(top: 50.0)), 
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(right: 30.0),
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  height: MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/main/tickets/qr.png')
                                    )
                                  ),
                                )   
                              )   
                            ],
                          )
                        )
                      ),
                    ]
                  )
                ),
              )
            )
          )
        )
      )
    );
  }
}