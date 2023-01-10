import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';

import '../counest_api_urls.dart';
import '../json_model/departments_list_model.dart';

class DepartmentsAPI extends ApiManager{
  @override
  String apiUrl() {
    return APIApp.departmentsUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return DepartmentsListModel.fromJson(data);
  }



}