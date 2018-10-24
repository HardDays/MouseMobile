import 'dart:math';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../widgets/main_button.dart';

import '../../../../resources/app_colors.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/storage/cache.dart';

class ShowsPage extends StatefulWidget  {

  final String title = 'SHOWS';

  Widget appBar;
  Function(Widget) onLoad;

  @override
  ShowsPageState createState() => ShowsPageState();
}

class ShowsPageState extends State<ShowsPage> {

  @override
  void initState() {
    super.initState();

    if (Cache.events == null){
      MainAPI.searchEvents().then(
        (res){
          setState(() {
            Cache.events = res;            
          });
        }
      );
    }
    
    WidgetsBinding.instance.addPostFrameCallback((_) => setState((){
      buildAppBar(context);
    }));
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
            icon: Icon(Icons.crop_square, color: Colors.white),
            onPressed: () {                   
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
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4 - 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: CachedNetworkImage(  
                          fadeOutDuration: Duration(milliseconds: 100),
                          fadeInDuration: Duration(milliseconds: 100),
                          imageUrl: event.imageId != null ? MainAPI.getImageUrl(event.imageId) : 'https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          placeholder: Image(fit: BoxFit.cover, image: NetworkImage('https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02')),
                          errorWidget: Image(fit: BoxFit.cover, image: NetworkImage('https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02'))
                        ), //NetworkImage('https://s3-alpha.figma.com/img/337a/eef7/6dacc3363f98f9ba67035e134c404f02')
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.0,),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4 - 20.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25.0),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.showCard.withOpacity(0.1),
                              AppColors.showCard.withOpacity(0.1),
                              AppColors.showCard.withOpacity(0.2),
                              AppColors.showCard.withOpacity(0.2),
                              AppColors.showCard.withOpacity(0.7),
                              AppColors.showCard.withOpacity(0.9),
                              AppColors.showCard.withOpacity(1.0)
                            ]
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4 - 55.0,
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
                                  height: 65.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        height: 26.0,
                                        child: Text(event.dateFrom.month.toString().padLeft(2, '0'),
                                          style: TextStyle(
                                            color: AppColors.secondRed,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 27.0
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 26.0,
                                        child: Text(event.dateFrom.day.toString().padLeft(2, '0'),
                                          style: TextStyle(
                                            color: AppColors.secondRed,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 27.0
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 13.0,
                                        child: Text(event.dateFrom.year.toString(),
                                          style: TextStyle(
                                            color: AppColors.secondRed,
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
                                  margin: EdgeInsets.only(left: 10.0),
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
                                              child: Text('${(100 * min(event.founded / max(1.0, event.fundingGoal), 1.0)).floor()}% Funded',
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
                                        child: Text('PROMO',
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
                                        child: Text(event.address?.toUpperCase() ?? '',
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
                        height: 50.0,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4 - 50.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                           /* Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              margin: EdgeInsets.only(right: 15.0, bottom: 5.0),
                              alignment: Alignment.centerRight,
                              child: Text('Starting from \$15',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w200
                                ),
                              ),
                            ),*/  
                            Container(
                              margin: EdgeInsets.only(right: 15.0, bottom: 5.0),
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 35.0,
                              child: MainButton('BUY TICKET'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            )
          ),
        ),
      );
    }
  }
}