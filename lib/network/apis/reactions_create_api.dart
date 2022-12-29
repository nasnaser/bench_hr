import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/counest_api_urls.dart';
import 'package:bench_hr/network/json_model/reactions_create_model.dart';

import 'api_manager.dart';

class ReactionsCreateAPI extends ApiManager {
  String idPost = "";

  @override
  String apiUrl() {
    return APIApp.createEmojeUrl + idPost + "/reactions/create";
  }

  @override
  AbstractJsonResource fromJson(data) {
    return ReactionsCateModel.fromJson(data);
  }
}
