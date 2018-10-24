import 'package:intl/intl.dart';

enum EventError { ok, unknownError }

class Event {

  EventError error = EventError.ok;

  int id;

  String name;
  String description;
  String address;

  bool isCrowdfunding;

  DateTime fundingFrom;
  DateTime fundingTo;

  DateTime dateFrom;
  DateTime dateTo;

  int imageId;
  int backers;

  double fundingGoal;
  double founded;

  Event({this.id, this.error, this.name, this.description, this.address, 
        this.imageId, this.fundingGoal, this.founded, this.backers,
        this.fundingFrom, this.fundingTo, this.dateFrom, this.dateTo, this.isCrowdfunding});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      imageId: json['image_id'],
      backers: json['backers'],
      fundingGoal: json['funding_goal'].toDouble(),
      founded: json['founded'].toDouble(),
      isCrowdfunding: json['is_crowdfunding_event'] ?? false,
      dateFrom: json['date_from'] != null ? DateTime.parse(json['date_from']) : null,
      dateTo: json['date_to'] != null ? DateTime.parse(json['date_to']) : null,
      error: EventError.ok
    );
  }

}