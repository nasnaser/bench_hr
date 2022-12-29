
import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/json_model/newsfeeds_model.dart';

import 'api_manager.dart';
import '../counest_api_urls.dart';


class NewsFeedsListAPI extends ApiManager{
  int PageNumber=0;
  @override
  String apiUrl() {
    return APIApp.newsFeedsListUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return NewsFeedsModel.fromJson(data);
  }

}