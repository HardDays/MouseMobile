import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../pages/main/shows/player_page.dart';

import '../routes/default_page_route.dart';

import '../../models/api/account.dart';

import '../../helpers/api/main_api.dart';

import '../../resources/app_colors.dart';

class YoutubeImage extends StatelessWidget {

  final double height;
  final double width;

  final String link;
  String imageUrl;

  YoutubeImage({this.link, this.width, this.height}){
    try {
      var id = FlutterYoutube.getIdFromUrl(link);
      imageUrl = 'https://img.youtube.com/vi/$id/hqdefault.jpg';
    } catch (Exception){
      imageUrl = '';
    }
  }

  Widget emptyImage(){
    return Container(
      color: Colors.black,
    );
  }
  
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 100),
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: emptyImage(),
              placeholder: emptyImage()
            ),
          ),
          IconButton(
            iconSize: 50.0,
            icon: Icon(Icons.play_circle_filled, color: Colors.white,),
            onPressed: (){
              // var id = FlutterYoutube.getIdFromUrl(link);
              // Navigator.push(
              //   context, 
              //   DefaultPageRoute(builder: (context) => PlayerPage(url: 'https://www.youtube.com/embed/$id?start=1')),
              // );
              FlutterYoutube.playYoutubeVideoByUrl(
                apiKey: 'AIzaSyBbKu_WyOweV8sfMmp3WSlEadHD1Vj4jUo',
                videoUrl: link,
                fullScreen: false
              );
            },
          )
        ]
      )
    );
  }
}