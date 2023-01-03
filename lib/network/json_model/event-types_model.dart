import 'package:bench_hr/network/apis/abstract_json_resource.dart';

class EventTypesModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  EventTypesModel({this.status, this.success, this.message, this.data});

  EventTypesModel.fromJson(Map<String, dynamic> json) {
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
  List<EventTypesList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <EventTypesList>[];
      json['list'].forEach((v) {
        list!.add(new EventTypesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventTypesList {
  int? id;
  String? name;
  String? icon;
  String? color;

  EventTypesList({this.id, this.name, this.icon, this.color});

  EventTypesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['color'] = this.color;
    return data;
  }
}
