// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong/latlong.dart';

// import 'widgets/ticket_header.dart';

// import '../../../widgets/main_button.dart';
// import '../../../widgets/main_tagbox.dart';
// import '../../../widgets/default_image.dart';

// import '../../../dialogs/dialogs.dart';
// import '../../../dialogs/genres_filter_dialog.dart';
// import '../../../dialogs/location_filter_dialog.dart';
// import '../../../dialogs/other_filter_dialog.dart';

// import '../../../routes/default_page_route.dart';

// import '../../../../models/api/ticket.dart';
// import '../../../../models/api/event.dart';

// import '../../../../resources/app_colors.dart';
// import '../../../../resources/translations.dart';

// import '../../../../helpers/storage/data_provider.dart';
// import '../../../../helpers/storage/filters/shows_filter.dart';

// class EventMapPage extends StatefulWidget {
//   Event event;

//   EventMapPage({this.event});

//   EventMapPageState createState() => EventMapPageState();
// }

// class EventMapPageState extends State<EventMapPage> {

//   @override
//   void initState() {
//     super.initState();

//   }

//   Widget buildAppBar(){
//     return PreferredSize( 
//       preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
//       child: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         elevation: 0.0,
//         title: Row(
//           children:[
//             Text('MAP',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.0,
//                 fontFamily: 'Avenir-Black', 
//               // fontStyle: FontStyle.italic
//               ),
//             )
//           ]
//         ),
//         backgroundColor: AppColors.appBar,
//         actions: [
//         ]
//       )
//     );
//   }

//   Widget build(BuildContext context){
//     return Scaffold(
//       backgroundColor: AppColors.mainBg,
//       appBar: buildAppBar(),
//       body: Container(
//         child: Container(    
//            margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
//            width: MediaQuery.of(context).size.width,
//            //height: MediaQuery.of(context).size.height * 1.0 - (MediaQuery.of(context).size.width * 0.2 + 50) - 134.0,       
//            child: FlutterMap(
//              options: MapOptions(
//              /*center: LatLng(widget.event.venue.,
//              zoom: 13.0,
//              onTap: (pos){
//                setState(() {
//                  clicked = -1;
//                  //selectedPlace = null;                          
//                });                        
//              },
//              onPositionChanged: (pos){
//                try {
//                  setState(() {
//                    showNearButton = geo.computeDistanceBetween(geo.LatLng(pos.center.latitude, pos.center.longitude), geo.LatLng(Cache.placesFilter.pos.latitude, Cache.placesFilter.pos.longitude)) > 7000;
//                  });
//                } catch (Exception){

//                }        
//              }             
//          ),                 
//          layers: [
//            TileLayerOptions(
//              urlTemplate: 'https://api.mapbox.com/styles/v1/vovan123/cjm3dcned9ve12snxbsnfoy38/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
//            //urlTemplate: "https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
//              additionalOptions: {
//                'accessToken': 'pk.eyJ1Ijoidm92YW4xMjMiLCJhIjoiY2o3aXNicTFhMW9jbDJxbWw3bHNqMW92MCJ9.N1hCLnBrJjdX0JmYuA8bOw',
//                'id': 'mapbox.streets',
//              },
//            ),
//            MarkerLayerOptions(
//              markers: List.generate(places.length, 
//                (index){
//                  var point = LatLng(places[index].lat, places[index].lng);
//                  return Marker(
//                    width: 50.0,
//                    height: 50.0,
//                    point: point,
//                    builder: (ctx) =>
//                      clicked != index ? GestureDetector(
//                        onTap: (){
//                          onPlace(index, context);
//                          setState(() {
//                            clicked = index;                                                                      
//                          });
//                        },
//                        child: Container(
//                          color: Colors.transparent,
//                          padding: EdgeInsets.all(18.0),
//                          width: 50.0,
//                          height: 50.0,
//                          child: Container(
//                            width: 20.0,
//                            height: 20.0,
//                            decoration: BoxDecoration(
//                              color: Theme.of(context).primaryColor,
//                              shape: BoxShape.circle
//                            ),
//                            child:Container(
//                              margin: EdgeInsets.all(1.5),
//                              width: 20.0,
//                              height: 20.0,
//                              decoration: BoxDecoration(
//                                color: Theme.of(context).accentColor,
//                                shape: BoxShape.circle
//                              ),           
//                            ),
//                          )
//                        )
//                      ) : Container(
//                        alignment: Alignment.topCenter,
//                        child:Container(
//                          width: 50.0,
//                          height: 50.0,
//                          child: DecoratedBox(
//                            decoration: BoxDecoration(                               
//                              image: DecorationImage(
//                                fit: BoxFit.cover,
//                                image: AssetImage('assets/images/logo.png'),
//                              ),
//                            ),
//                          )
//                        ),
//                      ),
//                    );
//                  }
//                )..add(pos != null ? Marker(
//                  width: 15.0, 
//                  height: 15.0,
//                  point: pos,
//                  builder: (ctx) => 
//                    Container(
//                      width: 25.0,
//                      height: 25.0,
//                      decoration: BoxDecoration(
//                        color: Colors.blueAccent.withAlpha(200),
//                        shape: BoxShape.circle
//                      ),
//                    )
//                  ): Marker(point: LatLng(0.0, 0.0))
//                ) 
//              ),
//            ],
//          ),
//         )
//       )
//     );
//   }
// }