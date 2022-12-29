class APIApp {
  static String APIKEY=
      "API-KEY";
  static String APIKEYVal=
      "6q^h6KGu^zJzAwR%s3Vt1mZHWIc5b8";


  static String LANG= "LANG";




  static const String baseUrl = 'https://api.bench.sa/api/v1/';


  static const String countrieslisUrl =baseUrl+"countries/list?page=";
  static const String newsFeedsListUrl =baseUrl+"newsfeeds?";
  static const String loginUrl =baseUrl+"login";
  static const String LogInVerifyUrl =baseUrl+"login/verify";
  static const String newsFeedsCommentsUrl =baseUrl+"newsfeeds/";
  static const String createNewsfeedsUrl =baseUrl+"newsfeeds";
  static const String deleteEmojeUrl =baseUrl+"newsfeeds/";
  static const String createEmojeUrl =baseUrl+"newsfeeds/";
  static const String eventsUrl =baseUrl+"events?date=";
  static const String employeesUrl =baseUrl+"employees";
  static const String personalUrl =employeesUrl+"/personal?uuid=";

}
