
import 'package:bench_hr/utility/storage.dart';
import 'package:dio/dio.dart'as di;
import 'package:get/get.dart';

import '../network/counest_api_urls.dart';



class AppInterCepter extends di.Interceptor{


  @override
  void onRequest(di.RequestOptions options,di. RequestInterceptorHandler handler) {
options.headers[APIApp.APIKEY]=APIApp.APIKEYVal;
options.headers[APIApp.LANG]=SecureStorage.readSecureData(SecureStorage.lang)??"ar";
options.headers[ "authorization"]=  "Bearer ${SecureStorage.readToken()}";
options.headers[ "device-key"]="mobile";
options.headers[ "company"]= SecureStorage.readCompany()??"";

super.onRequest(options, handler);

  }

  @override
  void onError(di.DioError err,di. ErrorInterceptorHandler handler) {
print("i get err");
print("*"*100);
print(err.toString());
print("*"*100);
Get.snackbar("err",err.message );
return super.onError(err, handler) ;
  }

  @override
  void  onResponse(di.Response response,di. ResponseInterceptorHandler handler) {
if(response.statusCode==200||response.statusCode==201){

}else{



 // Get.snackbar("err", "message");

}
 return super.onResponse(response, handler) ;}
}