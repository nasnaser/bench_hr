import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';
import 'package:bench_hr/network/counest_api_urls.dart';
import 'package:bench_hr/network/json_model/event-types_model.dart';


class EventTypesApi extends ApiManager{
  @override
  String apiUrl() {
    return APIApp.eventTypesUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return EventTypesModel.fromJson(data);
  }

}