
import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';
import 'package:bench_hr/network/json_model/events_model.dart';

import '../counest_api_urls.dart';


class EventsAPI extends ApiManager{
  String date="";
  @override
  String apiUrl() {
return APIApp.eventsUrl+date;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return EventsModel.fromJson(data);
  }

}