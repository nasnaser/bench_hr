import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';

import '../counest_api_urls.dart';
import '../json_model/events_details.dart';

class EventsDetailsApi extends ApiManager{
  String id="";
  @override
  String apiUrl() {
    return APIApp.eventsDetailsUrl+id ;
  }

  @override
  AbstractJsonResource fromJson(data) {
return EventsDetailsModel.fromJson(data);
  }

}