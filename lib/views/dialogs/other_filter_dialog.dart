import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_button.dart';
import '../widgets/main_tagbox.dart';
import '../widgets/main_checkbox.dart';

import '../dialogs/dialogs.dart';

import '../routes/default_page_route.dart';

import '../../models/api/venue_type.dart';
import '../../models/api/ticket.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/storage/filters/other_filter.dart';

class OtherFilterDialog extends StatefulWidget  {

  OtherFilter filter;

  Function(OtherFilter) onSave;

  OtherFilterDialog({this.filter, this.onSave});

  @override
  OtherFilterDialogState createState() => OtherFilterDialogState();
}

class OtherFilterDialogState extends State<OtherFilterDialog> {

  Set <String> venueTypes;
  Set <String> ticketTypes;

  void initState(){
    super.initState();

    venueTypes = widget.filter?.venueTypes?.toSet() ?? Set();
    ticketTypes = widget.filter?.ticketTypes?.toSet() ?? Set();
  }

  Widget buildCheckBox(String title){
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.only(left: 10.0),
      child: Row(
        children: <Widget>[
          MainCheckbox(
            
          ),
          Padding(padding: EdgeInsets.only(left: 10.0)),
          Text(title, 
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w300
            )
          )
        ],
      )
    );
  }

  @override 
  Widget build(BuildContext ctx){
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      //height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: AppColors.dialogBg,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('TICKET TYPE', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.0
              )
            ),
            Container(
             width: MediaQuery.of(context).size.width * 1.0,
             height: 40.0,
             margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 15.0),
             child: GridView.count(
               crossAxisCount: 2,
               childAspectRatio: 4.0,
               children: List.generate(TicketType.all.length, 
                 (ind) {
                    return Container(
                    //   margin: EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        children: <Widget>[ 
                          MainCheckbox(
                            checked: ticketTypes.contains(TicketType.all[ind]),
                            onTap: (){
                              setState(() { 
                                var type = TicketType.all[ind];
                                if (ticketTypes.contains(type)){
                                  ticketTypes.remove(type);
                                } else {
                                  ticketTypes.add(type);
                                }
                              });
                            },
                          ),
                          Padding(padding: EdgeInsets.only(left: 15.0)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text(Translations.translateEnum(TicketType.all[ind]),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300
                              ),
                            )
                          ),
                        ],
                      )
                    );
                  }
                )
              )
            ),
            Padding(padding: EdgeInsets.only(top: 25.0)),
            Text('VENUE TYPE', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.0
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.36,
              margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 15.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 4.0,
                children: List.generate(VenueType.all.length, 
                  (ind) {
                    return Container(
                    //   margin: EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        children: <Widget>[ 
                          MainCheckbox(
                            checked: venueTypes.contains(VenueType.all[ind]),
                            onTap: (){
                              setState(() {                                                          
                                var type = VenueType.all[ind];
                                if (venueTypes.contains(type)){
                                  venueTypes.remove(type);
                                } else {
                                  venueTypes.add(type);
                                }
                              });
                            },
                          ),
                          Padding(padding: EdgeInsets.only(left: 15.0)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.29,
                            child: Text(Translations.translateEnum(VenueType.all[ind]),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300
                              ),
                            )
                          )
                        ],
                      )
                    );
                  }
                )
              )
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width * 1.0,
              height: 40.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: MainButton('SAVE',
                  onTap: (){
                    Navigator.pop(context);     
                    if (widget.onSave != null){
                      widget.onSave(OtherFilter(ticketTypes: ticketTypes.toList(), venueTypes: venueTypes.toList()));
                    }
                  }
                )
              )
            )
          ],
        )
      )
    );
  }
}