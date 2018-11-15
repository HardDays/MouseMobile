import 'filters/shows_filter.dart';

import '../../models/api/event.dart';
import '../../models/api/account.dart';
import '../../models/api/feed_item.dart';
import '../../models/api/preferences.dart';

class Cache {

  static EventsFilter eventsFilter; 
  static EventsFilter ticketsFilter; 

  static Set<int> following;
  static List<Event> events;
  static List<FeedItem> feed;
  static Map<String, List<Event>> fanTickets;

  static Preferences preferences;
  
}