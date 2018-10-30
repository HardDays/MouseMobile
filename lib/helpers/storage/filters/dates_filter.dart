import 'package:intl/intl.dart';

class DatesFilter {

  DateTime dateFrom;
  DateTime dateTo;

  bool get isNotEmpty => dateFrom != null && dateTo != null;
  
  Map <String, dynamic> toJson(){
    Map <String, dynamic> res = {};

    if (isNotEmpty){
      res['from_date'] = DateFormat('dd.MM.yyyy').format(dateFrom);
      res['to_date'] = DateFormat('dd.MM.yyyy').format(dateTo);
    }
    
    return res;
  }

}