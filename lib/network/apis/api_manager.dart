import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart'  as a ;


import '../../utility/app_interceptor.dart';
import '../../utility/dio_singleton.dart';
import 'abstract_json_resource.dart';


abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  //final storge= a.Get.find<SecureStorage>();
  /// Returns the API URL of current API ressource
  ///
  ///
  ///

  String apiUrl();

  AbstractJsonResource fromJson(data);
  AppInterCepter appInterCepter=AppInterCepter();

  Future<AbstractJsonResource> getData() async {



    AbstractJsonResource jsonList;
    var data;
    dioSingleton.dio.interceptors.add( appInterCepter);
    await dioSingleton.dio
        .get( apiUrl()   )
        .then((value) {
          print(value);
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }
  Future<AbstractJsonResource> getpaginationData({required String url}) async {



    AbstractJsonResource jsonList;
    var data;
    dioSingleton.dio.interceptors.add( appInterCepter);
    await dioSingleton.dio
        .get(url  )
        .then((value) {
      print(value);
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }
/// POST DATA TO SERVER
  Future<Response<dynamic>> post(dataToPost) async {


    dioSingleton.dio.interceptors.add( appInterCepter);
    return dioSingleton.dio
        .post(
      apiUrl(),
      data: dataToPost,



    )
        .then((value) {
      print(value);


      return value;
    }).catchError((ee){
      print(ee.toString());
    });

  }


  /// del DATA TO SERVER
  Future<Response<dynamic>> deletePost() async {



    dioSingleton.dio.interceptors.add( appInterCepter);
    return dioSingleton.dio
        .delete(
        apiUrl() ,




    )
        .then((value) {
      return value;
    });
  }
}
