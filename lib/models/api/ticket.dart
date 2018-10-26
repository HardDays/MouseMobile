class Ticket {

  int id;

  String name;
  String description;

  double price;

  Ticket({this.id, this.name, this.price, this.description});
  
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
    );
  }

}