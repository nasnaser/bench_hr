import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart' as rootBundel;

class AllEmojiToView {
  static Map<String, EmojData> allEmojiMap = {};
  static List<String> allgroupEmoji = [];
  static List<EmojData> allEmojiList = [];
  static Map<String, List<EmojData>> groupEmoji = {};
  static List<EmojData> HostoryEmojiList = [];
  static List<CategoryEmoji> allgroupEmojiwithImage = [];


  static GetEmojis( ) async {
    EmojiJsonModel? emojiJsonModel;
    final jsondata =
        await rootBundel.rootBundle.loadString("assets/json/emoji_j.json");
    emojiJsonModel = EmojiJsonModel.fromJson(json.decode(jsondata));
    for (int i = 0; i < emojiJsonModel.data!.length; i++) {
      if(groupEmoji[emojiJsonModel.data![i].group!]==null){

        groupEmoji[emojiJsonModel.data![i].group!] =[];

        groupEmoji[emojiJsonModel.data![i].group!]!.add(emojiJsonModel.data![i]);
      }
        groupEmoji[emojiJsonModel.data![i].group!]!.add(emojiJsonModel.data![i]);


      allEmojiMap[emojiJsonModel.data![i].slug!] = emojiJsonModel.data![i];
      allEmojiList.add( emojiJsonModel.data![i]);
    }


    groupEmoji.forEach((key, value) {
      allgroupEmoji.add("1");
      allgroupEmoji.add(key);
    });
    groupEmoji["host"]=HostoryEmojiList;
    allgroupEmoji.insert(0, "host");
  }
  static String getEmojiName(String name) {
    if (name == "smileys-emotion") {
      return "Smileys & People";
    } else if (name == "people-body") {
// allgroupEmojiwithImage.add(CategoryEmoji(image: ,name: "Smileys & People"));
      return "1";
    } else if (name == "animals-nature") {
      return "Animal & Nature";
    } else if (name == "travel-places") {
      return "Travel & Places";
    } else if (name == "objects") {
      return "Objects";
    } else if (name == "symbols") {
      return "Symbols";
    } else if (name == "flags") {
      return "Flags";
    } else if (name == "activities") {
      return "Activities";
    } else if (name == "food-drink") {
      return "Food & Drink";
    }
    return "";
  }
}

class EmojiJsonModel {
  List< EmojData>? data;

  EmojiJsonModel({this.data});

  EmojiJsonModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = < EmojData>[];
      json['data'].forEach((v) {
        data!.add(new  EmojData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmojData {
  String? slug;
  String? character;
  String? unicodeName;
  String? codePoint;
  String? group;
  String? subGroup;
  List<Variants>? variants;

  EmojData(
      {this.slug,
      this.character,
      this.unicodeName,
      this.codePoint,
      this.group,
      this.subGroup,
      this.variants});

  EmojData.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    character = json['character'];
    unicodeName = json['unicodeName'];
    codePoint = json['codePoint'];
    group = json['group'];
    subGroup = json['subGroup'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['character'] = this.character;
    data['unicodeName'] = this.unicodeName;
    data['codePoint'] = this.codePoint;
    data['group'] = this.group;
    data['subGroup'] = this.subGroup;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  String? slug;
  String? character;

  Variants({this.slug, this.character});

  Variants.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    character = json['character'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['character'] = this.character;
    return data;
  }
}
class CategoryEmoji {
  final String name;
  final String image;

  CategoryEmoji({required this.name, required this.image});
}
