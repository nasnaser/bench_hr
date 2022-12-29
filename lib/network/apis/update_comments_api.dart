import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/json_model/news_feeds_comments_model.dart';

import 'api_manager.dart';
import '../counest_api_urls.dart';

import '../json_model/newsfeeds_model.dart';

class UpdateCommentsAPI extends ApiManager {
  String idPost = "";
  String idComment = "";

  @override
  String apiUrl() {
    return APIApp.newsFeedsCommentsUrl + idPost + "/comments/$idComment";
  }

  @override
  AbstractJsonResource fromJson(data) {
    return NewsFeedsCommentsModel.fromJson(data);
  }
}
