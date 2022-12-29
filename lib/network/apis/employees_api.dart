
import '../counest_api_urls.dart';
import '../json_model/employees_model.dart';
import 'abstract_json_resource.dart';
import 'api_manager.dart';

class EmployeesAPI extends ApiManager{
  @override
  String apiUrl() {
   return APIApp.employeesUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
return EmployeesModel.fromJson(data);
  }

}