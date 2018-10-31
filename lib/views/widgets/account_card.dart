import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'main_button.dart';
import 'main_tagbox.dart';

import '../../helpers/api/main_api.dart';

import '../../models/api/account.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';


class AccountCard extends StatelessWidget {
  
  Account account;

  AccountCard({this.account});
  
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        width: 60.0,  
                        child: ClipOval(
                          child: account.imageid != null ?
                          CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 100),
                            imageUrl: MainAPI.getImageUrl(account.imageid),
                            fit: BoxFit.cover,
                            errorWidget: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/common/empty_account.png')
                                )
                              ),
                            ),
                            placeholder: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/common/empty_account.png')
                                )
                              ),
                            ),
                          ) : 
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/common/empty_account.png')
                              )
                            ),
                          )
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(account.displayName ?? 'Unnamed',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 2.0)),  
                            Row(
                              children: <Widget>[
                                Text('@',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: AppColors.mainRed,
                                    fontSize: 13.0
                                  ),
                                ),
                                Text(account.userName ?? '',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.0
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 7.0)),  
                            Text((account.address ?? account.preferredAddress) ?? '',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 13.0
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: IconButton(
                      icon: Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/common/follow_icon.png')
                          )
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
            account.accountType == AccountType.artist && account.genres.isNotEmpty ? 
            Container(
              height: 35.0,
              width: MediaQuery.of(context).size.width * 1.0 - 90,
              margin: EdgeInsets.only(left: 90.0, right: 30.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(account.genres.length, 
                  (ind) {
                    return Container(
                      margin: EdgeInsets.only(top: 0.0, bottom: 10.0, right: 7.0),
                      child: MainTagbox(Translations.translateEnum(account.genres[ind]).toUpperCase(),
                        textStyle: TextStyle(
                          color: AppColors.genresText,
                          fontSize: 12.0
                        ),
                        uncheckedGradient: LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.3),
                            Colors.grey.withOpacity(0.3),
                          ]
                        ),
                      )
                    );
                  }
                )
              )
            ) 
            :
            Container(),
            Padding(padding: EdgeInsets.only(top: 0.0)),
            Divider(color: Colors.grey, height: 2.0,)
          ] 
        )
      )
    );
  }
}