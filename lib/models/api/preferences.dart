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

class Preferences {

  String language;
  String dateFormat;
  String distance;
  String currency;
  String timeFormat;

  Preferences( 
    {
      this.language = Language.engilsh, 
      this.dateFormat = DateFormatting.mmddyyyy, 
      this.distance = Distance.miles, 
      this.currency = Currency.dollar,
      this.timeFormat = TimeFormatting.t12
    }
  );
  
  Map <String, dynamic> toJson() {
    return {
      'preferred_language': language,
      'preferred_distance': distance,
      'preferred_currency': currency,
      'preferred_date': dateFormat,
      'preferred_time': timeFormat
    };
  }

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      language: json['preferred_language'] ?? Language.engilsh,
      currency: json['preferred_currency'] ?? Currency.dollar,
      distance: json['preferred_distance'] ?? Distance.miles,
      dateFormat: json['preferred_date'] ?? DateFormatting.mmddyyyy,
      timeFormat: json['preferred_time'] ?? TimeFormatting.t12,
    );
  }
}