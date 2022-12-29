import 'package:bench_hr/network/apis/abstract_json_resource.dart';

class LogInVerifyModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  LogInVerifyModel({this.status, this.success, this.message, this.data});

  LogInVerifyModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? redirectUrl;
  String? token;
  Permissions? permissions;

  Data({this.user, this.redirectUrl, this.token, this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    redirectUrl = json['redirect_url'];
    token = json['token'];
    permissions = json['permissions'] != null
        ? new Permissions.fromJson(json['permissions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['redirect_url'] = this.redirectUrl;
    data['token'] = this.token;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? employeeId;
  String? uuid;
  String? fullName;
  String? firstName;
  String? middleName;
  String? lastName;
  JobTitle? jobTitle;
  JobTitle? department;
  String? company;
  String? timezone;
  String? role;
  String? profilePhoto;

  User(
      {this.id,
        this.employeeId,
        this.uuid,
        this.fullName,
        this.firstName,
        this.middleName,
        this.lastName,
        this.jobTitle,
        this.department,
        this.company,
        this.timezone,
        this.role,
        this.profilePhoto});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    uuid = json['uuid'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    jobTitle = json['job_title'] != null
        ? new JobTitle.fromJson(json['job_title'])
        : null;
    department = json['department'] != null
        ? new JobTitle.fromJson(json['department'])
        : null;
    company = json['company'];
    timezone = json['timezone'];
    role = json['role'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['uuid'] = this.uuid;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    if (this.jobTitle != null) {
      data['job_title'] = this.jobTitle!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    data['company'] = this.company;
    data['timezone'] = this.timezone;
    data['role'] = this.role;
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

class Permissions {
  List<String>? employeeAddresses;
  List<String>? employeeBenefits;
  List<String>? employeeContactInfos;
  List<String>? employeeContracts;
  List<String>? employeeDepartments;
  List<String>? employeeEducationalHistories;
  List<String>? employeeEmergencyContactInfos;
  List<String>? employeeFamilyMembers;
  List<String>? employeeJobTitles;
  List<String>? employeeLineManagers;
  List<String>? employeeOfficeLocations;
  List<String>? employeeOfficialDocuments;
  List<String>? employeePersonalInfos;
  List<String>? employeePersonalInfoHobby;
  List<String>? employeeProbationPeriods;
  List<String>? employeeTeams;
  List<String>? employeeVacationPolicy;
  List<String>? hobbies;
  List<String>? nationalities;
  List<String>? religions;
  List<String>? employeeWorkSchedules;
  List<String>? employeeCompensationPackages;

  Permissions(
      {this.employeeAddresses,
        this.employeeBenefits,
        this.employeeContactInfos,
        this.employeeContracts,
        this.employeeDepartments,
        this.employeeEducationalHistories,
        this.employeeEmergencyContactInfos,
        this.employeeFamilyMembers,
        this.employeeJobTitles,
        this.employeeLineManagers,
        this.employeeOfficeLocations,
        this.employeeOfficialDocuments,
        this.employeePersonalInfos,
        this.employeePersonalInfoHobby,
        this.employeeProbationPeriods,
        this.employeeTeams,
        this.employeeVacationPolicy,
        this.hobbies,
        this.nationalities,
        this.religions,
        this.employeeWorkSchedules,
        this.employeeCompensationPackages});

  Permissions.fromJson(Map<String, dynamic> json) {
    employeeAddresses = json['employee_addresses'].cast<String>();
    employeeBenefits = json['employee_benefits'].cast<String>();
    employeeContactInfos = json['employee_contact_infos'].cast<String>();
    employeeContracts = json['employee_contracts'].cast<String>();
    employeeDepartments = json['employee_departments'].cast<String>();
    employeeEducationalHistories =
        json['employee_educational_histories'].cast<String>();
    employeeEmergencyContactInfos =
        json['employee_emergency_contact_infos'].cast<String>();
    employeeFamilyMembers = json['employee_family_members'].cast<String>();
    employeeJobTitles = json['employee_job_titles'].cast<String>();
    employeeLineManagers = json['employee_line_managers'].cast<String>();
    employeeOfficeLocations = json['employee_office_locations'].cast<String>();
    employeeOfficialDocuments =
        json['employee_official_documents'].cast<String>();
    employeePersonalInfos = json['employee_personal_infos'].cast<String>();
    employeePersonalInfoHobby =
        json['employee_personal_info_hobby'].cast<String>();
    employeeProbationPeriods =
        json['employee_probation_periods'].cast<String>();
    employeeTeams = json['employee_teams'].cast<String>();
    employeeVacationPolicy = json['employee_vacation_policy'].cast<String>();
    hobbies = json['hobbies'].cast<String>();
    nationalities = json['nationalities'].cast<String>();
    religions = json['religions'].cast<String>();
    employeeWorkSchedules = json['employee_work_schedules'].cast<String>();
    employeeCompensationPackages =
        json['employee_compensation_packages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_addresses'] = this.employeeAddresses;
    data['employee_benefits'] = this.employeeBenefits;
    data['employee_contact_infos'] = this.employeeContactInfos;
    data['employee_contracts'] = this.employeeContracts;
    data['employee_departments'] = this.employeeDepartments;
    data['employee_educational_histories'] = this.employeeEducationalHistories;
    data['employee_emergency_contact_infos'] =
        this.employeeEmergencyContactInfos;
    data['employee_family_members'] = this.employeeFamilyMembers;
    data['employee_job_titles'] = this.employeeJobTitles;
    data['employee_line_managers'] = this.employeeLineManagers;
    data['employee_office_locations'] = this.employeeOfficeLocations;
    data['employee_official_documents'] = this.employeeOfficialDocuments;
    data['employee_personal_infos'] = this.employeePersonalInfos;
    data['employee_personal_info_hobby'] = this.employeePersonalInfoHobby;
    data['employee_probation_periods'] = this.employeeProbationPeriods;
    data['employee_teams'] = this.employeeTeams;
    data['employee_vacation_policy'] = this.employeeVacationPolicy;
    data['hobbies'] = this.hobbies;
    data['nationalities'] = this.nationalities;
    data['religions'] = this.religions;
    data['employee_work_schedules'] = this.employeeWorkSchedules;
    data['employee_compensation_packages'] = this.employeeCompensationPackages;
    return data;
  }
}
