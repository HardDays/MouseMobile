import 'dates_filter.dart';
import 'other_filter.dart';
import 'location_filter.dart';
import 'genres_filter.dart';

class EventsFilter {

  DatesFilter datesFilter = DatesFilter();
  OtherFilter otherFilter = OtherFilter();
  GenresFilter genresFilter = GenresFilter();
  LocationFilter locationFilter = LocationFilter();

  Map <String, dynamic> toJson(){
    Map <String, dynamic> res = {};
    res.addAll(datesFilter.toJson());
    res.addAll(otherFilter.toJson());
    res.addAll(genresFilter.toJson());
    res.addAll(locationFilter.toJson());
    return res;
  }

}