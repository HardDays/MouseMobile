import 'package:intl/intl.dart';

import '../../resources/translations.dart';

import '../../models/api/preferences.dart';


class Formatter {

  static String dateSettings = DateFormatting.mmddyyyy;
  static String timeSettings = TimeFormatting.t12;

  static String shortDate(DateTime date){
    if (dateSettings == DateFormatting.ddmmyyyy){
      return DateFormat('dd.MM.yyyy').format(date);
    } else {
      return DateFormat('MM.dd.yyyy').format(date);
    }
  }

  static String longDate(DateTime date){
    if (dateSettings == DateFormatting.mmddyyyy){
      return '${Translations.translateEnum(DateFormat.MMMM().format(date))} ${DateFormat.d().format(date)}, ${DateFormat.y().format(date)}';
    } else {
      return '${DateFormat.d().format(date)} ${Translations.translateEnum(DateFormat.MMMM().format(date))}, ${DateFormat.y().format(date)}';
    }
  }

  static String long3Date(DateTime date){
    if (dateSettings == DateFormatting.mmddyyyy){
      return '${Translations.translateEnum(DateFormat.MMMM().format(date)).substring(0, 3).toUpperCase()} ${DateFormat.d().format(date)}, ${DateFormat.y().format(date)}';
    } else {
      return '${DateFormat.d().format(date)} ${Translations.translateEnum(DateFormat.MMMM().format(date)).substring(0, 3).toUpperCase()}, ${DateFormat.y().format(date)}';
    }
  }

  static String time(DateTime date){
    if (timeSettings == TimeFormatting.t12){
      return DateFormat('h:mma').format(date);
    } else {
      return DateFormat('hh:mm').format(date);
    }
  }

}