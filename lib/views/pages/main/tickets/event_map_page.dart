import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'widgets/ticket_header.dart';

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
import '../../../../models/api/account.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/storage/filters/shows_filter.dart';

class EventMapPage extends StatefulWidget {
  
  Event event;

  EventMapPage({this.event});

  EventMapPageState createState() => EventMapPageState();
}

class EventMapPageState extends State<EventMapPage> {
  Account venue;
  LatLng center;

  MapController mapController;

  @override
  void initState() {
    super.initState();

    mapController = MapController();
    if (venue == null){
      DataProvider.getAccount(widget.event.venue.id).then(
        (res){
          if (res.status == DataStatus.ok){
            setState(() {
              venue = res.result;
              if (mapController.ready){
                if (venue.lat != null && venue.lng != null){
                  center = LatLng(venue.lat, venue.lng + 0.02);
                  mapController.move(center, mapController.zoom);
                }
              }
            });
          }
        }
      );
    }
    mapController.onReady.then(
      (res){
        if (venue != null){
          if (venue.lat != null && venue.lng != null){
            center = LatLng(venue.lat, venue.lng + 0.02);
            mapController.move(center, mapController.zoom);
          }
        }
      }
    );
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Row(
          children:[
            Text(Translations.map.toUpperCase(),
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
    );
  }

  Widget build(BuildContext context){
    if (venue == null){
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: Container(
          child: Stack(
            children: <Widget>[ 
              Container(    
                width: MediaQuery.of(context).size.width,
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: center,
                    zoom: 13.0        
                  ),                 
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                      additionalOptions: {
                        'accessToken': 'pk.eyJ1Ijoidm92YW4xMjMiLCJhIjoiY2o3aXNicTFhMW9jbDJxbWw3bHNqMW92MCJ9.N1hCLnBrJjdX0JmYuA8bOw',
                        'id': 'mapbox.streets',
                      },
                    ),
                    MarkerLayerOptions(
                      // markers: venue.lat != null && venue.lng != null ? [
                      //   Marker(
                      //     width: 30.0,
                      //     height: 30.0,
                      //     point: LatLng(venue.lat, venue.lng),
                      //     builder: (ctx) =>
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //           image: AssetImage('assets/images/common/pin.png')
                      //         )
                      //       ),
                      //     )    
                      //   )
                      // ] : 
                      markers: []
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/common/pin.png')
                        )
                      ),
                    ),    
                    Padding(padding: EdgeInsets.only(left: 10.0)),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      width: 240.0,
                      height: 85.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            //margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                            width: 70.0,
                            height: 85.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: DefaultImage(id: widget.event.imageId)
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 7.0),
                                  width: 170.0,
                                  child: Text(widget.event.name?.toUpperCase() ?? Translations.unnamed.toUpperCase(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'Avenir-Black'
                                    ),
                                  ),
                                ),
                                widget.event?.venue?.displayName != null ? 
                                Container(
                                  width: 170.0,
                                  padding: EdgeInsets.only(left: 7.0),
                                  child: Text(widget.event?.venue?.displayName ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Avenir-Book', 
                                      fontSize: 14.0
                                    )
                                  )
                                ) :
                                Container(),         
                                
                                widget.event.address != null ?
                                GestureDetector(
                                  child: Container(
                                    width: 170.0,
                                    padding: EdgeInsets.only(left: 7.0, bottom: 10.0),
                                    child: Text(widget.event.address ?? '',
                                      maxLines: 2,
                                      style: TextStyle(
                                        height: 15.0 / 14.0,
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontFamily: 'Avenir-Book', 
                                      )
                                    )
                                  )  
                                ) :
                                Container(),
                              ]
                            )
                          ),
                        ]
                      )
                    ),
                  ]
                )
              )
            ]   
          )
        )
      );
    }
  }
}