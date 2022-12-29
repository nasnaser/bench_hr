import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';
import 'package:bench_hr/network/json_model/logIn_verify_model.dart';

import '../counest_api_urls.dart';
import '../json_model/logIn_model.dart';

class LoginVerifyApi extends ApiManager {
  @override
  String apiUrl() {
    return APIApp.LogInVerifyUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return LogInVerifyModel.fromJson(data);
  }
}
