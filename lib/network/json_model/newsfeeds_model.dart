
import '../apis/abstract_json_resource.dart';

class NewsFeedsModel extends AbstractJsonResource {
  int? status;
  bool? success;
  String? message;
  Data? data;

  NewsFeedsModel({this.status, this.success, this.message, this.data});

  NewsFeedsModel.fromJson(Map<String, dynamic> json) {
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
  List<NewsFeedsList>? list;
  Pagination? pagination;

  Data({this.list, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <NewsFeedsList>[];
      json['list'].forEach((v) {
        list!.add(new NewsFeedsList.fromJson(v));
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

class NewsFeedsList {
  int? id;
  String? title;
  String? description;
  String? publishedAt;
  int? commentEnabled;
  int? emojiEnabled;
  int? commentsCount;
  Employee? employee;
  List<Reactions>? reactions;
  List<Attachment>? attachment;

  NewsFeedsList(
      {this.id,
        this.title,
        this.description,
        this.publishedAt,
        this.commentEnabled,
        this.emojiEnabled,
        this.commentsCount,
        this.employee,
        this.reactions,
        this.attachment});

  NewsFeedsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    commentEnabled = json['comment_enabled'];
    emojiEnabled = json['emoji_enabled'];
    commentsCount = json['comments_count'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    if (json['reactions'] != null) {
      reactions = <Reactions>[];
      json['reactions'].forEach((v) {
        reactions!.add(new Reactions.fromJson(v));
      });
    }
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
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.map((v) => v.toJson()).toList();
    }
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.map((v) => v.toJson()).toList();
    }
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

class Reactions {
  String? defaultEmoji;
  int? total;
  int? selected;

  Reactions({this.defaultEmoji, this.total, this.selected});

  Reactions.fromJson(Map<String, dynamic> json) {
    defaultEmoji = json['default_emoji'];
    total = json['total'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['default_emoji'] = this.defaultEmoji;
    data['total'] = this.total;
    data['selected'] = this.selected;
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
