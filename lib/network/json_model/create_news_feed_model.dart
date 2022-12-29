

import '../apis/abstract_json_resource.dart';

class CreateNewsfeedModel extends AbstractJsonResource{
  int? status;
  bool? success;
  String? message;
  Data? data;

  CreateNewsfeedModel({this.status, this.success, this.message, this.data});

  CreateNewsfeedModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? publishedAt;
  String? commentEnabled;
  String? emojiEnabled;
  int? commentsCount;

  List<Attachment>? attachment;

  Data(
      {this.id,
        this.title,
        this.description,
        this.publishedAt,
        this.commentEnabled,
        this.emojiEnabled,
        this.commentsCount,

        this.attachment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    commentEnabled = json['comment_enabled'];
    emojiEnabled = json['emoji_enabled'];
    commentsCount = json['comments_count'];

    if (json['attachment'] != null) {
      attachment = <Attachment>[];
      json['attachment'].forEach((v) {
        attachment!.add(new Attachment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['published_at'] = this.publishedAt;
    data['comment_enabled'] = this.commentEnabled;
    data['emoji_enabled'] = this.emojiEnabled;
    data['comments_count'] = this.commentsCount;

    if (this.attachment != null) {
      data['attachment'] = this.attachment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachment {
  int? id;
  Employee? employee;
  String? attachment;
  String? type;

  Attachment({this.id, this.employee, this.attachment, this.type});

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    attachment = json['attachment'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['attachment'] = this.attachment;
    data['type'] = this.type;
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
