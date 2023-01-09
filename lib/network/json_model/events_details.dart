import '../apis/abstract_json_resource.dart';

class EventsDetailsModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  EventsDetailsModel({this.status, this.success, this.message, this.data});

  EventsDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? startDate;
  String? endDate;
  EventType? eventType;
  Employee? employee;

  Data(
      {this.id,
        this.name,
        this.nameAr,
        this.description,
        this.descriptionAr,
        this.startDate,
        this.endDate,
        this.eventType,
        this.employee});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    eventType = json['event_type'] != null
        ? new EventType.fromJson(json['event_type'])
        : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.eventType != null) {
      data['event_type'] = this.eventType!.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class EventType {
  int? id;
  String? name;
  String? nameAr;
  String? icon;
  String? color;
  Null? backgroundColor;

  EventType(
      {this.id,
        this.name,
        this.nameAr,
        this.icon,
        this.color,
        this.backgroundColor});

  EventType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    icon = json['icon'];
    color = json['color'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
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
  String? nameAr;

  JobTitle({this.id, this.name, this.nameAr});

  JobTitle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    return data;
  }
}
