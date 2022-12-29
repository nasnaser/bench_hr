import 'package:dio/dio.dart';


class DioSingleton {
  Dio dio = Dio(BaseOptions(
      headers: {
        'apikey': "",
        'Content-Type': 'application/json'
      }
      ));
  static final DioSingleton _singleton = DioSingleton._internal();

  factory DioSingleton() {
    return _singleton;
  }

  DioSingleton._internal();
}
