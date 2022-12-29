
import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';
import 'package:bench_hr/network/json_model/logIn_model.dart';

import '../counest_api_urls.dart';


class LoginApi extends ApiManager{
  @override
  String apiUrl() {
return APIApp.loginUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return LogInModel.fromJson(data);
  }

}