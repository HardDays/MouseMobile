class LocationFilter {
  
  double lat;
  double lng;
  double radius;

  String address;

  LocationFilter({this.lat, this.lng, this.radius, this.address});

  bool get isNotEmpty => lat != null && lng != null && radius != null;

  Map <String, dynamic> toJson(){
    Map <String, dynamic> res = {};

    if (isNotEmpty){
      res['lat'] = lat;
      res['lng'] = lng;
      res['distance'] = radius;
      res['units'] = 'km';
    }
    
    return res;
  }
  
}