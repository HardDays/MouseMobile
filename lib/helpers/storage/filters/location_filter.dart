class LocationFilter {
  
  double lat;
  double lng;
  double radius;

  bool get isEmpty => lat == null || lng == null;
  
}