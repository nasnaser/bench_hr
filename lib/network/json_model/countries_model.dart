

import '../apis/abstract_json_resource.dart';

class CountriesModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  CountriesModel({this.status, this.success, this.message, this.data});

  CountriesModel.fromJson(Map<String, dynamic> json) {
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
  List<ConutriesList>? list;
  Pagination? pagination;

  Data({this.list, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ConutriesList>[];
      json['list'].forEach((v) {
        list!.add(new ConutriesList.fromJson(v));
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

class ConutriesList {
  int? id;
  String? name;
  String? icon;
  String? code;

  ConutriesList({this.id, this.name, this.icon, this.code});

  ConutriesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['code'] = this.code;
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
