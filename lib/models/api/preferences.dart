class Language {
  static const String engilsh = 'en';
  static const String russian = 'ru';
  
  static const List<String> all = [engilsh, russian];
}

class DateFormatting {
  static const String mmddyyyy = 'MMDDYYYY';
  static const String ddmmyyyy = 'DDMMYYYY';

  static const List<String> all = [mmddyyyy, ddmmyyyy];
}

class TimeFormatting {
  static const String t24 = '24';
  static const String t12 = '12';

  static const List<String> all = [t24, t12];
}

class Distance {
  static const String kilometers = 'km';
  static const String miles = 'mi';

  static const List<String> all = [kilometers, miles];
}

class Currency {
  static const String ruble = 'RUB';
  static const String dollar = 'USD';
  static const String euro = 'EUR';

  static const List<String> all = [ruble, dollar, euro];
}

class NotificationHistoty {
  static const String daily = 'daily';
  static const String weekly = 'weekly';
  static const String monthly = 'monthly';

  static const List<String> all = [daily, weekly, monthly];
}

class Preferences {

  String language;
  String dateFormat;
  String distance;
  String currency;
  String timeFormat;

  bool notifShowsNear;
  bool notifShowsFavorite;
  bool notifMessagesSent;

  String notifHistory;

  Preferences( 
    {
      this.language = Language.engilsh, 
      this.dateFormat = DateFormatting.mmddyyyy, 
      this.distance = Distance.miles, 
      this.currency = Currency.dollar,
      this.timeFormat = TimeFormatting.t12,
      this.notifShowsNear = false,
      this.notifShowsFavorite = false,
      this.notifMessagesSent = false,
      this.notifHistory
    }
  );
  
  Map <String, dynamic> toJson() {
    return {
      'preferred_language': language,
      'preferred_distance': distance,
      'preferred_currency': currency,
      'preferred_date': dateFormat,
      'preferred_time': timeFormat,
      'notif_shows_near': notifShowsNear,
      'notif_shows_favorite': notifShowsFavorite,
      'notif_messages_sent': notifMessagesSent,
      'notif_history': notifHistory,
    };
  }

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      language: json['preferred_language'] ?? Language.engilsh,
      currency: json['preferred_currency'] ?? Currency.dollar,
      distance: json['preferred_distance'] ?? Distance.miles,
      dateFormat: json['preferred_date'] ?? DateFormatting.mmddyyyy,
      timeFormat: json['preferred_time'] ?? TimeFormatting.t12,
      notifMessagesSent: json['notif_messages_sent'] ?? false,
      notifShowsFavorite: json['notif_shows_favorite'] ?? false,
      notifShowsNear: json['notif_shows_near'] ?? false,
      notifHistory: json['notif_history'],
    );
  }
}