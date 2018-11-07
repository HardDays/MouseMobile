import 'package:flutter/material.dart';

import '../profile_edit_page.dart';

import '../../../../widgets/follow_button.dart';
import '../../../../widgets/main_tagbox.dart';
import '../../../../widgets/account_image.dart';
import '../../../../widgets/default_image.dart';
import '../../../../widgets/youtube_image.dart';
import '../../../../widgets/followers_buttons.dart';
import '../../../../widgets/main_button.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../../models/api/account.dart';

import '../../../../../helpers/api/main_api.dart';
import '../../../../../helpers/storage/database.dart';

import '../../../../../resources/translations.dart';
import '../../../../../resources/app_colors.dart';

class AccountHeader extends StatefulWidget {
  Account account;

  AccountHeader({this.account});

  AccountHeaderState createState() => AccountHeaderState();
}

class AccountHeaderState extends State<AccountHeader> {
  
  String about;

  Account account;

  final icons = {
    AccountType.artist: 'assets/images/main/profile/artist_icon.png',
    AccountType.fan: 'assets/images/main/profile/fan_icon.png',
    AccountType.venue: 'assets/images/main/profile/venue_icon.png',
  };
  
  @override
  void initState(){
    super.initState();

    account = widget.account;

    if (account.accountType == AccountType.fan){
      about = account.bio;
    } else if (account.accountType == AccountType.artist){
      about = account.about;
    } else {
      about = account.description;
    }
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: <Widget>[
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/main/profile/account_header.png')
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
              width: 100.0,
              height: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: AccountImage(account: account)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 110.0, right: 15.0),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[  
                  Container(
                    height: 30.0,
                    child: Database.getCurrentAccount()?.id == account.id ? 
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          DefaultPageRoute(builder: (context) => ProfileEditPage()),
                        ).then(
                          (res) {
                            setState(() {
                              account = Database.getCurrentAccount();                                
                            });
                          }
                        ); 
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.editProfile.withOpacity(0.7)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0), 
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(3.0),
                            bottomLeft: Radius.circular(3.0)
                          )
                        ),
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        alignment: Alignment.center,
                        child: Text('Edit Profile',
                          style: TextStyle(
                            color: AppColors.editProfile,
                            fontSize: 14.0,
                            fontFamily: 'Avenir-Medium'
                          ),
                        ),
                      )
                    ) :
                    FollowButton(account: account)
                  ),
                ]
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 70.0, right: 15.0),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(icons[account.accountType])
                      )
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 5.0)),
                  Text(Translations.translateEnum(account.accountType).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontFamily: 'Avenir-Heavy', 
                    ),
                  )
                ],
              )
            ),
          ]
        ),
        Container(
          margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
          child: Text(account.displayName ?? 'Unnamed',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: 'Avenir-Black', 
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
          child: Row(
            children: <Widget>[
              Text('@',
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Avenir-Book', 
                  color: AppColors.mainRed,
                  fontSize: 16.0
                ),
              ),
              Text(account.userName ?? '',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontFamily: 'Avenir-Book', 
                  fontSize: 16.0
                ),
              ),
            ],
          ),
        ),

        about != null ? 
        Container(
          margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
          child: Text(about,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: 'Avenir-Book', 
            ),
          ),
        ) : 
        Container(),

        account.genres.isNotEmpty && account.accountType != AccountType.venue ? 
        Container(
          margin: EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
          height: 25.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(account.genres.length, 
              (ind) {
                return Container(
                  margin: EdgeInsets.only(right: 7.0),
                  child: MainTagbox(Translations.translateEnum(account.genres[ind]).toUpperCase(),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Book',
                      fontSize: 12.0
                    ),
                    uncheckedGradient: LinearGradient(
                      colors: [
                        Colors.grey.withOpacity(0.2),
                        Colors.grey.withOpacity(0.2),
                      ]
                    ),
                  )
                );
              }
            )
          )
        ) :
        Container(),
        
        account.accountType != AccountType.venue ? 
        Container(
          margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 20.0),
          child: FollowersButton(account: account)
        ) :
        Container(),
      ]
    );    
  }
}