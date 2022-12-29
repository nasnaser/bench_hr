
import 'abstract_json_resource.dart';
import 'api_manager.dart';
import '../counest_api_urls.dart';
import '../json_model/create_news_feed_model.dart';
import '../json_model/news_feeds_comments_model.dart';
import '../json_model/newsfeeds_model.dart';

class CreateNewsFeedsAPI extends ApiManager{

  @override
  String apiUrl() {
    return APIApp.createNewsfeedsUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return CreateNewsfeedModel.fromJson(data);
  }

}