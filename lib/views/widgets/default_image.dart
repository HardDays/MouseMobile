import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/api/account.dart';

import '../../helpers/api/main_api.dart';

import '../../resources/app_colors.dart';

class DefaultImage extends StatelessWidget {

  final int id;

  DefaultImage({this.id});

  Widget emptyImage(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/common/empty_account.png')
        )
      )
    );
  }
  
  Widget build(BuildContext context) {
    return Container(
      child: id != null ?
      CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: 100),
        imageUrl: MainAPI.getImageUrl(id),
        fit: BoxFit.cover,
        errorWidget: emptyImage(),
        placeholder: emptyImage()
      ) : 
      emptyImage()
    );
  }
}