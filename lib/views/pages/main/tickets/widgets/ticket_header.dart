import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../event_map_page.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../widgets/default_image.dart';

import '../../../../../models/api/ticket.dart';
import '../../../../../models/api/event.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class TicketHeader extends StatelessWidget {


  bool showDivider;
  Event event;

  TicketHeader({this.event, this.showDivider = true});

  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[ 
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                width: 120.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: DefaultImage(id: event.imageId)
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0 - 200.0,
                      child: Text(event.name?.toUpperCase() ?? 'UNNAMED',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Avenir-Black'
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 2.0),
                          width: 15.0, 
                          height: 15.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/common/pin.png')
                            )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            event?.venue?.displayName != null ? 
                            Container(
                              width: MediaQuery.of(context).size.width * 1.0 - 200.0,
                              padding: EdgeInsets.only(left: 7.0),
                              child: Text(event?.venue?.displayName ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir-Book', 
                                  fontSize: 14.0
                                )
                              )
                            ) :
                            Container(),         
                            
                            event.address != null ?
                            GestureDetector(
                              onTap: (){
                                if (event.venue != null){
                                  Navigator.push(
                                    context,
                                    DefaultPageRoute(builder: (context) => EventMapPage(event: event)),
                                  );  
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1.0 - 200.0,
                                padding: EdgeInsets.only(left: 7.0, bottom: 10.0),
                                child: Text(event.address ?? '',
                                  maxLines: 2,
                                  style: TextStyle(
                                    height: 15.0 / 14.0,
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontFamily: 'Avenir-Book', 
                                  )
                                )
                              )  
                            ) :
                            Container(),
                            
                            event.dateFrom != null ? 
                            Container(
                              width: MediaQuery.of(context).size.width * 1.0 - 200.0,
                              padding: EdgeInsets.only(left: 7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${Translations.translateEnum(DateFormat.MMMM().format(event.dateFrom))} ${DateFormat.d().format(event.dateFrom)}, ${DateFormat.y().format(event.dateFrom)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir-Medium',
                                      fontSize: 16.0
                                    )
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 5.0)),
                                  Text('${DateFormat('h:mma').format(event.dateFrom)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir-Medium',
                                      fontSize: 16.0
                                    )
                                  ),
                                ],
                              ),
                            ) : 
                            Container(),
                          ]
                        )       
                      ],
                    ),         
                  ],
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 25.0)),
          showDivider ? 
          Divider(
            height: 2.0,
            color: Colors.grey.withOpacity(0.5)
          ) : 
          Container()
        ]
      )
    );
  }
}