
import '../apis/abstract_json_resource.dart';

class PersonalModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  PersonalModel({this.status, this.success, this.message, this.data});

  PersonalModel.fromJson(Map<String, dynamic> json) {
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
  String? uuid;
  String? fullName;
  String? firstName;
  String? firstNameAr;
  String? middleName;
  String? middleNameAr;
  String? lastName;
  String? lastNameAr;
  String? username;
  String? email;
  String? phone;
  String? employeeNumber;
  JobTitle? jobTitle;
  Steps? steps;
  int? mudadService;
  int? absherService;
  int? gosiService;
  int? qiwaService;
  int? personalSim;
  String? birthdate;
  String? gender;
  Nationality? nationality;
  Nationality? religion;
  List<Hobbies>? hobbies;
  Status? status;
  String? profilePhoto;

  Data(
      {this.uuid,
        this.fullName,
        this.firstName,
        this.firstNameAr,
        this.middleName,
        this.middleNameAr,
        this.lastName,
        this.lastNameAr,
        this.username,
        this.email,
        this.phone,
        this.employeeNumber,
        this.jobTitle,
        this.steps,
        this.mudadService,
        this.absherService,
        this.gosiService,
        this.qiwaService,
        this.personalSim,
        this.birthdate,
        this.gender,
        this.nationality,
        this.religion,
        this.hobbies,
        this.status,
        this.profilePhoto});

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    firstNameAr = json['first_name_ar'];
    middleName = json['middle_name'];
    middleNameAr = json['middle_name_ar'];
    lastName = json['last_name'];
    lastNameAr = json['last_name_ar'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    employeeNumber = json['employee_number'];
    jobTitle = json['job_title'] != null
        ? new JobTitle.fromJson(json['job_title'])
        : null;
    steps = json['steps'] != null ? new Steps.fromJson(json['steps']) : null;
    mudadService = json['mudad_service'];
    absherService = json['absher_service'];
    gosiService = json['gosi_service'];
    qiwaService = json['qiwa_service'];
    personalSim = json['personal_sim'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    nationality = json['nationality'] != null
        ? new Nationality.fromJson(json['nationality'])
        : null;
    religion = json['religion'] != null
        ? new Nationality.fromJson(json['religion'])
        : null;
    if (json['hobbies'] != null) {
      hobbies = <Hobbies>[];
      json['hobbies'].forEach((v) {
        hobbies!.add(new Hobbies.fromJson(v));
      });
    }
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['first_name_ar'] = this.firstNameAr;
    data['middle_name'] = this.middleName;
    data['middle_name_ar'] = this.middleNameAr;
    data['last_name'] = this.lastName;
    data['last_name_ar'] = this.lastNameAr;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['employee_number'] = this.employeeNumber;
    if (this.jobTitle != null) {
      data['job_title'] = this.jobTitle!.toJson();
    }
    if (this.steps != null) {
      data['steps'] = this.steps!.toJson();
    }
    data['mudad_service'] = this.mudadService;
    data['absher_service'] = this.absherService;
    data['gosi_service'] = this.gosiService;
    data['qiwa_service'] = this.qiwaService;
    data['personal_sim'] = this.personalSim;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    if (this.nationality != null) {
      data['nationality'] = this.nationality!.toJson();
    }
    if (this.religion != null) {
      data['religion'] = this.religion!.toJson();
    }
    if (this.hobbies != null) {
      data['hobbies'] = this.hobbies!.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
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

class Nationality {
  int? id;
  String? name;
  String? color;
  String? backgroundColor;

  Nationality({this.id, this.name, this.color, this.backgroundColor});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['background_color'] = this.backgroundColor;
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
class Hobbies {
  int? id;
  String? name;

  Hobbies({this.id, this.name});

  Hobbies.fromJson(Map<String, dynamic> json) {
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