
import 'abstract_json_resource.dart';
import 'api_manager.dart';
import '../counest_api_urls.dart';
import '../json_model/delete_emoje_model.dart';
import '../json_model/news_feeds_comments_model.dart';
import '../json_model/newsfeeds_model.dart';

class DeleteEmojeAPI extends ApiManager{
  String idPost="";

  @override
  String apiUrl() {
    return APIApp.deleteEmojeUrl+idPost+"/reactions/delete";
  }

  @override
  AbstractJsonResource fromJson(data) {
    return DeleteEmojeModel.fromJson(data);
  }

}