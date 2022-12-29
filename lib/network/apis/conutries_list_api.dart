
import 'package:flutter/cupertino.dart';

import '../counest_api_urls.dart';
import '../json_model/countries_model.dart';
import '../json_model/logIn_model.dart';
import 'abstract_json_resource.dart';
import 'api_manager.dart';

class ConutriesListAPI extends ApiManager{
  int PageNumber=0;
  @override
  String apiUrl() {
return APIApp.countrieslisUrl+PageNumber.toString();
  }

  @override
  AbstractJsonResource fromJson(data) {
    return CountriesModel.fromJson(data);
  }

}