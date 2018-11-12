import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import 'fan_page.dart';
import 'artist_page.dart';
import 'venue_page.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/main_checkbox.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/genre.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';

class ProfileEditPage extends StatefulWidget {

  ProfileEditPage();

  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> with SingleTickerProviderStateMixin {
 
  GlobalKey<FormState> formKey;

  File image;

  Account account;

  String userName;
  String firstName;
  String lastName;
  String bio;

  Set<String> genres;
  
  @override
  void initState(){
    super.initState();
    
    account = DataProvider.getCachedCurrentAccount();
    genres = account.genres.toSet();
    formKey = GlobalKey<FormState>();
  }

  void onSave(){
    formKey.currentState.save();
    if (formKey.currentState.validate()){
      Dialogs.showLoader(context);
      account.firstName = firstName;
      account.lastName = lastName;
      account.userName = userName;
      account.bio = bio;
      account.genres = genres.toList();
      if (image != null){
        account.image = base64Encode(image.readAsBytesSync());
      }
      DataProvider.updateAccount(account).then(
        (res)  {
          Navigator.pop(context);
          if (res.status == DataStatus.ok){
            account = res.result;
            Dialogs.showMessage(context, title: 'Success', body: 'Profile was updated', ok: 'Ok').then((res){
              Navigator.pop(context);
            });
          } else {
            Dialogs.showMessage(context, title: 'Cannot update profile', body: 'Username already taken', ok: 'Ok');
          }
        }
      );
    }
  }

  void onImageSelect() async {
    var res = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (res != null){
        image = res;                                        
      }
    });
  }

  String validateUserName(String username){
    if (username.length < 3 || username.length > 30){
      return Translations.wrongUsernameSize;
    } else if (!RegExp(r'^[a-zA-Z0-9\._]+$').hasMatch(username)){
      return Translations.wrongUsernameSymbols;
    }
  }

  String validateName(String name){
    if (name.length < 1 || name.length > 50){
      return Translations.wrongNameSize;
    }
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Row(
          children:[
            Container(
              child: Text('EDIT PROFILE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Avenir-Black', 
                // fontStyle: FontStyle.italic
                ),
              )
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [
          IconButton(
            onPressed: onSave,
            iconSize: 40.0,
            icon: Text('SAVE',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Avenir-Medium', 
              ),
            ),
          )
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext ctx) {
    if (account == null){
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: Center(
          child: SingleChildScrollView(

          ),         
        ),        
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          height: 100.0,
                          child: image != null ? 
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(image)
                              )
                            ),
                          ) : 
                          (account.imageid != null ? 
                            AccountImage(account: account) : 
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                              ), 
                            )
                          )
                        ),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.3)
                          ),
                          child: IconButton(
                            onPressed: onImageSelect,
                            icon: Icon(Icons.photo_camera, color: Colors.white),
                          ),
                        )
                      ]
                    ),
                  ),
                ]
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 12.0),
                child: Divider(color: Colors.white.withOpacity(0.15), height: 2.0),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text('First name',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14.0,
                                fontFamily: 'Avenir-Medium'
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              initialValue: account.firstName,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Avenir-Book', 
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Enter first name',       
                                hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontFamily: 'Avenir-Book', 
                                )     
                              ),
                              validator: validateName,
                              onSaved: (val){
                                this.firstName = val;
                              },
                            )
                          ),
                        ],
                      ),            
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Divider(color: Colors.white.withOpacity(0.15), height: 2.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text('Last name',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14.0,
                                fontFamily: 'Avenir-Medium'
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              initialValue: account.lastName,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Avenir-Book', 
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Enter last name',       
                                hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontFamily: 'Avenir-Book', 
                                )     
                              ),
                              validator: validateName,
                              onSaved: (val){
                                this.lastName = val;
                              },
                            )
                          ),
                        ],
                      ),            
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Divider(color: Colors.white.withOpacity(0.15), height: 2.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text('Username',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14.0,
                                fontFamily: 'Avenir-Medium'
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text('@',
                                  style: TextStyle(
                                    color: AppColors.textRed,
                                    fontSize: 14.0,
                                    fontFamily: 'Avenir-Medium'
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.0),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  initialValue: account.userName,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'Avenir-Book', 
                                  ),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Enter username',       
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontFamily: 'Avenir-Book', 
                                    )     
                                  ),
                                  validator: validateUserName,
                                  onSaved: (userName){
                                    this.userName = userName;
                                  },
                                )
                              ),
                            ]
                          )
                        ],
                      ),            
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Divider(color: Colors.white.withOpacity(0.15), height: 2.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text('Bio',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14.0,
                                fontFamily: 'Avenir-Medium'
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              initialValue: account.bio,
                              maxLines: null,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Avenir-Book', 
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Enter bio',       
                                hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontFamily: 'Avenir-Book', 
                                )     
                              ),
                              onSaved: (val){
                                this.bio = val;
                              },
                            )
                          ),
                        ],
                      ),            
                    ),
                  ]
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Divider(color: Colors.white.withOpacity(0.15), height: 2.0),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Genre',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.0,
                        fontFamily: 'Avenir-Medium'
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: MediaQuery.of(context).size.height * 0.33,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 3.0,
                        children: List.generate(Genre.all.length, 
                          (ind) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                children: <Widget>[ 
                                  MainCheckbox(
                                    checked: genres.contains(Genre.all[ind]),
                                    onTap: (){
                                      setState(() {
                                        if (genres.contains(Genre.all[ind])){
                                          genres.remove(Genre.all[ind]);
                                        } else {
                                          genres.add(Genre.all[ind]);
                                        }                       
                                      });
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 15.0)),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width * 0.28,
                                    child: Text(Translations.translateEnum(Genre.all[ind]),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontFamily: 'Avenir-Book', 
                                      ),
                                    ),
                                  )
                                ],
                              )
                            );
                          }
                        )
                      )
                    ),
                  ],
                ),
              )
            ] 
          )
        ),        
      );
    }
  }
} 