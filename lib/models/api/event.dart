import 'package:intl/intl.dart';

import 'ticket.dart';
import 'account.dart';
import 'comment.dart';

enum EventError { ok, unknownError }

class Event {

  EventError error = EventError.ok;

  int id;

  String name;
  String description;
  String address;
  String hashtag;
  String currency;

  bool isCrowdfunding;

  DateTime fundingFrom;
  DateTime fundingTo;

  DateTime dateFrom;
  DateTime dateTo;

  int imageId;
  int backers;

  double fundingGoal;
  double founded;

  Account venue;
  List<Ticket> tickets;
  List <String> genres;
  List <Account> artists;
  List <Comment> comments;

  Event({this.id, this.error, this.name, this.description, this.address, this.hashtag,
      this.imageId, this.fundingGoal, this.founded, this.backers, this.currency,
      this.fundingFrom, this.fundingTo, this.dateFrom, this.dateTo, this.isCrowdfunding,
      this.venue, this.tickets, this.genres, this.artists, this.comments = const []
    }
  ) {
    tickets.sort((t1, t2) => t1.price.compareTo(t2.price));
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      hashtag: json['hashtag'],
      address: json['address'] ?? '',
      imageId: json['image_id'],
      backers: json['backers'] ?? 0,
      currency: json['currency'],
      fundingGoal: json['funding_goal']?.toDouble() ?? 0.0,
      founded: json['founded']?.toDouble() ?? 0.0,
      isCrowdfunding: json['is_crowdfunding_event'] ?? false,
      dateFrom: json['date_from'] != null ? DateTime.parse(json['date_from']) : null,
      dateTo: json['date_to'] != null ? DateTime.parse(json['date_to']) : null,
      fundingFrom: json['funding_from'] != null ? DateTime.parse(json['funding_from']) : null,
      fundingTo: json['funding_to'] != null ? DateTime.parse(json['funding_to']) : null,
      venue: json['venue'] != null ? Account.fromJson(json['venue']) : null,
      tickets: json['tickets'] != null ? json['tickets'].map<Ticket>((x) => Ticket.fromJson(x)).toList() : [],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      artists: json['artist'] != null ? json['artist'].map<Account>((x) => Account(id: x['artist_id'])).toList() : [],
      error: EventError.ok
    );
  }

}