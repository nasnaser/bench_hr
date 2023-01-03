import 'package:bench_hr/network/apis/abstract_json_resource.dart';
import 'package:bench_hr/network/json_model/events_model.dart';

class AllEventsModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  AllEventsModel({this.status, this.success, this.message, this.data});

  AllEventsModel.fromJson(Map<String, dynamic> json) {
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
  List<EventsList>? list;
  Pagination? pagination;

  Data({this.list, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <EventsList>[];
      json['list'].forEach((v) {
        list!.add(new EventsList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}



class EventType {
  int? id;
  String? name;
  String? icon;
  String? color;
  Null? backgroundColor;

  EventType({this.id, this.name, this.icon, this.color, this.backgroundColor});

  EventType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['color'] = this.color;
    data['background_color'] = this.backgroundColor;
    return data;
  }
}

class Employee {
  int? id;
  String? uuid;
  String? fullName;
  JobTitle? jobTitle;
  String? profilePhoto;

  Employee(
      {this.id, this.uuid, this.fullName, this.jobTitle, this.profilePhoto});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    fullName = json['full_name'];
    jobTitle = json['job_title'] != null
        ? new JobTitle.fromJson(json['job_title'])
        : null;
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['full_name'] = this.fullName;
    if (this.jobTitle != null) {
      data['job_title'] = this.jobTitle!.toJson();
    }
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class JobTitle {
  int? id;
  String? name;

  JobTitle({this.id, this.name});

  JobTitle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Pagination {
  int? count;
  int? totalCount;
  int? currentPage;
  int? lastPage;
  String? next;
  String? prev;

  Pagination(
      {this.count,
        this.totalCount,
        this.currentPage,
        this.lastPage,
        this.next,
        this.prev});

  Pagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalCount = json['total_count'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_count'] = this.totalCount;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}
