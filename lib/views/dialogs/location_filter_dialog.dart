import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_button.dart';
import '../widgets/main_tagbox.dart';
import '../widgets/address_autocomplete.dart';

import '../dialogs/dialogs.dart';

import '../routes/default_page_route.dart';

import '../../models/api/genre.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/storage/filters/location_filter.dart';
import '../../helpers/storage/data_provider.dart';

class LocationFilterDialog extends StatefulWidget  {

  LocationFilter filter;

  Function(LocationFilter) onSave;

  LocationFilterDialog({this.filter, this.onSave});

  @override
  LocationFilterDialogState createState() => LocationFilterDialogState();
}

class LocationFilterDialogState extends State<LocationFilterDialog> {

  double radius;
  double lat;
  double lng;
  String address;

  AddressAutocompleteController autcompleteController;
  TextEditingController addressController;

  void initState(){
    super.initState();

    radius = widget.filter?.radius ?? 10.0;
    lat = widget.filter?.lat;
    lng = widget.filter?.lng;
    address = widget.filter?.address;

    autcompleteController = AddressAutocompleteController();
    addressController = TextEditingController(text: address);
  }

  @override 
  Widget build(BuildContext ctx){
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
     // height: MediaQuery.of(context).size.height * 0.37,
      decoration: BoxDecoration(
        color: AppColors.dialogBg,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 10.0, top: 5.0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: 20.0, 
                  height: 20.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/common/pin.png')
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  width: MediaQuery.of(context).size.width * 1.0 - 115,
                  child: TextField(
                    controller: addressController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Book',
                      fontSize: 16.0
                    ),
                    decoration: InputDecoration(
                      hintText: Translations.address,
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'Avenir-Book', 
                        fontSize: 16.0
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.8)
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)))
                    ),
                    onChanged: (val){
                      setState(() {
                        lat = null;
                        lng = null;
                        address = val;
                        autcompleteController.setAddress(address);
                      });
                    },
                  ),
                ),
              ]
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 55.0, top: 5.0),
            child: AddressAutocomplete(
              onSelect: (address){
                setState(() {
                  this.address = address.address;
                  this.lat = address.location.lat;
                  this.lng = address.location.lng;       
                  addressController.text = this.address;          
                });
              },
              controller: autcompleteController,
              textStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Avenir-Book',  
                fontSize: 14.0
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: Text('${Translations.distanceAround} (${radius.floor()} ${Translations.translateEnum(DataProvider.preferences.distance)})',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontFamily: 'Avenir-Book', 
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
            child: Slider(
              value: radius,
              min: 1.0,
              max: 200.0,
              activeColor: AppColors.redRightGradButton,
              inactiveColor: Colors.grey.withOpacity(0.2),
              onChanged: (val){
                setState(() {
                  radius = val;                  
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width * 1.0,
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Text(Translations.reset.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Heavy', 
                      fontSize: 16.0
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      lat = null;
                      lng = null;
                      radius = 10.0;
                      address = null;
                      addressController.clear();
                    });
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MainButton(Translations.save.toUpperCase(),
                    onTap: (){
                      Navigator.pop(context);     
                      if (widget.onSave != null){
                        widget.onSave(LocationFilter(lat: lat, lng: lng, radius: radius, address: address));
                      }
                    },
                  )
                ),
              ]
            )
          ),
        ],
      )
    );
  }
}