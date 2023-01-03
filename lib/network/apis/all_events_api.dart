import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';
import 'package:bench_hr/network/counest_api_urls.dart';
import 'package:bench_hr/network/json_model/all_events_model.dart';

class AlleventsApi extends ApiManager{
  @override
  String apiUrl() {
    return APIApp.AlleventsUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return AllEventsModel.fromJson(data);
  }

}