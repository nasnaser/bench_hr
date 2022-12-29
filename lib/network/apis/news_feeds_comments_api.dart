
import 'package:bench_hr/network/apis/abstract_json_resource.dart';

import 'api_manager.dart';
import '../counest_api_urls.dart';
import '../json_model/news_feeds_comments_model.dart';
import '../json_model/newsfeeds_model.dart';

class NewsFeedsCommentsAPI extends ApiManager{
  String id="";
  @override
  String apiUrl() {
    return APIApp.newsFeedsCommentsUrl+id+"/comments";
  }

  @override
  NewsFeedsCommentsModel fromJson(data) {
    return NewsFeedsCommentsModel.fromJson(data);
  }

}