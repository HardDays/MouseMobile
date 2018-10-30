class OtherFilter {
  
  List <String> ticketTypes;
  List <String> venueTypes;

  OtherFilter({this.ticketTypes = const [], this.venueTypes = const []});

  bool get isNotEmpty => ticketTypes.isNotEmpty || venueTypes.isNotEmpty;
  
  Map <String, dynamic> toJson(){
    Map <String, dynamic> res = {};

    if (ticketTypes.isNotEmpty){
      res['ticket_types'] = ticketTypes;
    }
    if (venueTypes.isNotEmpty){
      res['size'] = venueTypes;
    } 
    
    return res;
  }
}