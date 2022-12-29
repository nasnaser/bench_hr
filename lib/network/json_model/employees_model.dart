
import '../apis/abstract_json_resource.dart';

class EmployeesModel  extends AbstractJsonResource {
  int? status;
  bool? success;
  String? message;
  Data? data;

  EmployeesModel({this.status, this.success, this.message, this.data});

  EmployeesModel.fromJson(Map<String, dynamic> json) {
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
  List<MyList>? list;
  Pagination? pagination;

  Data({this.list, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <MyList>[];
      json['list'].forEach((v) {
        list!.add(new MyList.fromJson(v));
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

class MyList {
  int? id;
  int? userId;
  String? uuid;
  String? fullName;
  String? workEmail;
  MobileCountry? mobileCountry;
  String? mobile;
  String? lastLogin;
  String? hiredAt;
  bool? completed;
  Steps? steps;
  Status? status;
  Department? department;
  Department? jobTitle;
  LineManger? lineManger;
  String? profilePhoto;

  MyList(
      {this.id,
        this.userId,
        this.uuid,
        this.fullName,
        this.workEmail,
        this.mobileCountry,
        this.mobile,
        this.lastLogin,
        this.hiredAt,
        this.completed,
        this.steps,
        this.status,
        this.department,
        this.jobTitle,
        this.lineManger,
        this.profilePhoto});

  MyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    uuid = json['uuid'];
    fullName = json['full_name'];
    workEmail = json['work_email'];
    mobileCountry = json['mobile_country'] != null
        ? new MobileCountry.fromJson(json['mobile_country'])
        : null;
    mobile = json['mobile'];
    lastLogin = json['last_login'];
    hiredAt = json['hired_at'];
    completed = json['completed'];
    steps = json['steps'] != null ? new Steps.fromJson(json['steps']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    jobTitle = json['job_title'] != null
        ? new Department.fromJson(json['job_title'])
        : null;
    lineManger = json['line_manger'] != null
        ? new LineManger.fromJson(json['line_manger'])
        : null;
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['uuid'] = this.uuid;
    data['full_name'] = this.fullName;
    data['work_email'] = this.workEmail;
    if (this.mobileCountry != null) {
      data['mobile_country'] = this.mobileCountry!.toJson();
    }
    data['mobile'] = this.mobile;
    data['last_login'] = this.lastLogin;
    data['hired_at'] = this.hiredAt;
    data['completed'] = this.completed;
    if (this.steps != null) {
      data['steps'] = this.steps!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.jobTitle != null) {
      data['job_title'] = this.jobTitle!.toJson();
    }
    if (this.lineManger != null) {
      data['line_manger'] = this.lineManger!.toJson();
    }
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class MobileCountry {
  int? id;
  String? name;
  String? icon;
  String? code;

  MobileCountry({this.id, this.name, this.icon, this.code});

  MobileCountry.fromJson(Map<String, dynamic> json) {
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

class Steps {
  String? current;
  List<String>? completed;

  Steps({this.current, this.completed});

  Steps.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    completed = json['completed'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['completed'] = this.completed;
    return data;
  }
}

class Status {
  int? id;
  String? name;
  String? icon;
  String? color;
  String? backgroundColor;

  Status({this.id, this.name, this.icon, this.color, this.backgroundColor});

  Status.fromJson(Map<String, dynamic> json) {
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

class Department {
  int? id;
  String? name;

  Department({this.id, this.name});

  Department.fromJson(Map<String, dynamic> json) {
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

class LineManger {
  int? id;
  String? uuid;
  String? fullName;
  Department? jobTitle;
  String? profilePhoto;

  LineManger(
      {this.id, this.uuid, this.fullName, this.jobTitle, this.profilePhoto});

  LineManger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    fullName = json['full_name'];
    jobTitle = json['job_title'] != null
        ? new Department.fromJson(json['job_title'])
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
