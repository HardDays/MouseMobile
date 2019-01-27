
class TicketType {
  static const String vr = 'vr';
  static const String inPerson = 'in_person';

  static const List<String> all = [
    vr, inPerson
  ];
}

class TicketTime {
  static const String past = 'past';
  static const String current = 'current';
}

class Ticket {

  int id;
  int ticketsLeft;

  String name;
  String description;
  String type;
  String currency;

  bool isPromotional;
  bool isPersonal;

  double price;


  Ticket({this.id, this.name, this.price, this.description, this.type, this.currency, this.isPromotional, this.isPersonal, this.ticketsLeft});
  
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      name: json['name'] ?? '',
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      description: json['description'] ?? '',
      currency: json['currency'] ?? 'USD',
      isPromotional: json['is_promotional'] ?? false,
      ticketsLeft: json['tickets_left'] ?? 0,
      type: json['type'] ?? TicketType.inPerson,
      isPersonal: json['is_for_personal_use'] ?? false
    );
  }

}