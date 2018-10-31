import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'main_button.dart';

import '../../helpers/api/main_api.dart';

import '../../models/api/event.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';


class EventCard extends StatelessWidget {
  
  final Event event;

  EventCard({this.event});
  
  Widget build(BuildContext context) {
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
}