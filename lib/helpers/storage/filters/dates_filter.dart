class DatesFilter {

  DateTime dateFrom;
  DateTime dateTo;

  bool get isNotEmpty => !(dateFrom == null || dateTo == null);
  
}