import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../pages/main/profile/account_page.dart';
import '../routes/default_page_route.dart';

import '../../models/api/account.dart';

import '../../helpers/api/main_api.dart';

import '../../resources/app_colors.dart';

class AccountImage extends StatelessWidget {

  final Account account;
  
  final double size;

  final bool clickable;

  AccountImage({this.account, this.size = 60.0, this.clickable = true});

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
    return GestureDetector(
      onTap: (){
        if (clickable){
          Navigator.push(
            context,
            DefaultPageRoute(builder: (context) => AccountPage(id: account.id)),
          );  
        }
      },
      child: Container(
        height: size,
        width: size,  
        child: ClipOval(
          child: account.imageid != null ?
          CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 100),
            imageUrl: MainAPI.getImageUrl(account.imageid),
            fit: BoxFit.cover,
            errorWidget: emptyImage(),
            placeholder: emptyImage()
          ) : 
          emptyImage()
        ),
      )
    );
  }
}