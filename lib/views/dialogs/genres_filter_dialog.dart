import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_button.dart';
import '../widgets/main_tagbox.dart';
import '../widgets/main_checkbox.dart';

import '../dialogs/dialogs.dart';

import '../routes/default_page_route.dart';

import '../../models/api/genre.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/storage/cache.dart';

class GenresFilterDialog extends StatefulWidget  {


  @override
  GenresFilterDialogState createState() => GenresFilterDialogState();
}

class GenresFilterDialogState extends State<GenresFilterDialog> {

  List <String> genres;

  void initState(){
    super.initState();

    genres = Genre.all;
  }

  @override 
  Widget build(BuildContext ctx){
    return Container(
       width: MediaQuery.of(context).size.width * 1.0,
       height: MediaQuery.of(context).size.height * 0.7,
       decoration: BoxDecoration(
         color: AppColors.dialogBg,
         borderRadius: BorderRadius.all(Radius.circular(5.0))
       ),
       child: Column(
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
             child: TextField(
               style: TextStyle(
                 color: Colors.white
               ),
               decoration: InputDecoration(
                 hintText: 'Search',
                 hintStyle: TextStyle(
                   color: Colors.white.withOpacity(0.5)
                 ),
                 focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                 enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
               ),
               onChanged: (val){
                 setState(() {
                   if (val.isNotEmpty){
                     genres = Genre.all.where((genre) => genre.toLowerCase().contains(val.toLowerCase())).toList();
                   } else {
                     genres = Genre.all;
                   }         
                 });
               },
             ),
           ),
           Divider(
             height: 2.0, 
             color: Colors.grey.withOpacity(0.5)
           ),
           Container(
             width: MediaQuery.of(context).size.width * 1.0,
             height: MediaQuery.of(context).size.height * 0.47,
             margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
             child: GridView.count(
               crossAxisCount: 2,
               childAspectRatio: 3.0,
               children: List.generate(genres.length, 
                 (ind) {
                   return Container(
                     margin: EdgeInsets.only(bottom: 15.0),
                     child: Row(
                       children: <Widget>[ 
                         MainCheckbox(),
                         Padding(padding: EdgeInsets.only(left: 15.0)),
                         Text(genres[ind],
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 15.0,
                             fontWeight: FontWeight.w300
                           ),
                         )
                       ],
                     )
                   );
                 }
               )
             )
           ),
           Container(
             margin: EdgeInsets.only(top: 20.0),
             width: MediaQuery.of(context).size.width * 0.4,
             height: 40.0,
             child: MainButton('SAVE')
           )
         ],
       )
     );
  }
}