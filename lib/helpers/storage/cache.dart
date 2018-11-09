import 'filters/shows_filter.dart';

import '../../models/api/event.dart';
import '../../models/api/account.dart';

class Cache {

  static EventsFilter eventsFilter; 
  static EventsFilter ticketsFilter; 

  static Set<int> following;
  static List<Event> events;
  
  static Map<String, List<Event>> fanTickets;

}