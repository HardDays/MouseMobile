class Venue {

  int id;

  String displayName;
  String address;
  String description;
  String venueType;

  Venue({this.id, this.displayName, this.address, this.description, this.venueType});
  
  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      address: json['address'] ?? '',
      displayName: json['display_name'],
      description: json['description'],
      venueType: json['venue_type']
    );
  }

}