 
 

import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/apis/api_manager.dart';
import 'package:bench_hr/network/counest_api_urls.dart';
import 'package:bench_hr/network/json_model/personal_model.dart';

class PersonalAPI extends ApiManager{
  String date="";
  @override
  String apiUrl() {
return APIApp.personalUrl+date+"&for=onboarding";
  }

  @override
  AbstractJsonResource fromJson(data) {
   return PersonalModel.fromJson(data);
  }

}