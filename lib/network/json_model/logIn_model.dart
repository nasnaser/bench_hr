
import '../apis/abstract_json_resource.dart';

class LogInModel  extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;

  LogInModel({this.status, this.success, this.message});

  LogInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
