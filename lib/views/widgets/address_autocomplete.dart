import 'package:flutter/material.dart';
import "package:google_maps_webservice/places.dart";

import '../../resources/app_colors.dart';

class PredictPlace {
  String id;
  String address;
  Location location;

  PredictPlace({this.id, this.address, this.location});
}


class AddressAutocompleteController {
  String address;

  Function(String) _onAddressChange;

  AddressAutocompleteController({this.address}){

  }

  void setAddress(String address){
    _onAddressChange(address);
  }
}

class AddressAutocomplete extends StatefulWidget {
  
  final AddressAutocompleteController controller;

  final TextStyle textStyle;

  Function(PredictPlace) onSelect;

  AddressAutocomplete({
    this.textStyle = const TextStyle(
      color: Colors.white
    ),
    this.controller,
    this.onSelect
  });

  @override
  AddressAutocompleteState  createState() => AddressAutocompleteState();
}

class AddressAutocompleteState extends State<AddressAutocomplete> {
  
  List<PredictPlace> list = [];

  GoogleMapsPlaces places = GoogleMapsPlaces('AIzaSyAsj_-JGBuK2AQVGagT3pAT-uzQvnUKfrg');

  String address;

  @override
  void initState(){
    super.initState();

    widget.controller?._onAddressChange = update;
  }

  void update(String addr){
    setState(() {
      address = addr;      
    });
    if (address != null && address.isNotEmpty){
      places.autocomplete(address, types: ['(cities)']).then(
        (response){
          if (response.isOkay){
            setState(() {
              list = response.predictions.map((pr) => PredictPlace(address: pr.description, id: pr.placeId)).take(3).toList();               
            });      
          } else {
            setState(() {
              list = [];    
            });  
          }
        }
      );
    } else {
      setState(() {
        list = [];    
      });  
    }
  }
  
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(list.length, 
        (ind) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              alignment: Alignment.topLeft,
              child: Text(list[ind].address,
                style: widget.textStyle
              )
            ),
            onTap: () async {
              if (widget.onSelect != null){
                if (list[ind].id != null){
                  var res = await places.getDetailsByPlaceId(list[ind].id);
                  if (res.isOkay){
                    var location = res.result?.geometry?.location;
                    list[ind].location = location;
                  }
                }
                widget.onSelect(list[ind]);
              }
              setState(() {
                list = [];     
                update(null);
              });
            },
          );
        }
      )
    );
  }
}