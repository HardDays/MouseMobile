import 'filters/shows_filter.dart';

import '../../models/api/event.dart';
import '../../models/api/account.dart';

class Cache {

  static ShowsFilter showsFilter = ShowsFilter(); 

  static List<int> following = [];
  static List<Event> events;
}