
import '../apis/abstract_json_resource.dart';

class ReactionsCateModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  ReactionsCateModel({this.status, this.success, this.message, this.data});

  ReactionsCateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? defaultEmoji;

  Data({this.defaultEmoji});

  Data.fromJson(Map<String, dynamic> json) {
    defaultEmoji = json['default_emoji'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['default_emoji'] = this.defaultEmoji;
    return data;
  }
}
