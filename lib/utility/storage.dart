
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SecureStorage  {
  static   String _Token="token";
  static   String _LogIn="login";
 static String lang="lang";
  static String _company="company";
  static String _intro="intro";
 static GetStorage box = GetStorage();

static  Future writeSecureData(String key, String value)  async {




    var writeData = await box.write( key,value);
    return writeData;
  }

  static  Future writeIntro(  String value)  async {




    var writeData = await box.write( _intro,value);
    return writeData;
  }

  static String? readIntro()   {

    var readData =   box.read( _intro);
    return readData;
  }

  static  Future writeCompany(  String value)  async {




    var writeData = await box.write( _company,value);
    return writeData;
  }
  static String? readCompany()   {

    var readData =   box.read( _company);
    return readData;
  }



  static  Future writeBoolData(String key, bool value)  async {


    var writeData = await box.write( key,value);
    return writeData;
  }
  static bool readBoolData(String key)   {

    var readData =   box.read( key);
    return readData;
  }
  static String? readSecureData(String key)   {

    var readData =   box.read( key);
    return readData;
  }
  static Future deleteSecureData(String key) async{

    var deleteData = await box.remove( key);
    return deleteData;
  }


    static Future writeToken(String token) async{

      var deleteData = await box.write( _Token,token);

    }
  static String? readToken( )  {

    var deleteData =   box.read( _Token);
return deleteData;
  }
  static  Future writeSecureJsonData({ required value})  async {


    var writeData = await box.write( _LogIn,value);
    return writeData;
  }
  static Map<String,dynamic>? readLogInJson( )   {

    var readData =   box.read( _LogIn);
    return readData;
  }
}