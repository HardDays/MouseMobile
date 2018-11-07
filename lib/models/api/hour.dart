class Hours {
  static const String sunday = 'sunday';
  static const String monday = 'monday';
  static const String tuesday = 'tuesday';
  static const String wednesday = 'wednesday';
  static const String thursday = 'thursday';
  static const String friday = 'friday';
  static const String saturday = 'saturday';

  static const List all = [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
}

class Hour {
  String day;
  DateTime beginTime;
  DateTime endTime;

  Hour({this.day, this.beginTime, this.endTime});

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      day: json['day'],
      beginTime: json['begin_time'] != null ? DateTime.parse(json['begin_time']) : null,
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null
    );
  }
}