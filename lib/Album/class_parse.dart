import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class clas {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  List<String>? student;
  String? name;
  int? group;
  String? teacher;

  clas(
      {this.className,
      this.objectId,
      this.createdAt,
      this.updatedAt,
      this.student,
      this.name,
      this.group,
      this.teacher});

  clas.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    student = json['student'].cast<String>();
    name = json['name'];
    group = json['group'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['className'] = this.className;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['student'] = this.student;
    data['name'] = this.name;
    data['group'] = this.group;
    data['teacher'] = this.teacher;
    return data;
  }
}

class ClassList {
  final List<clas> albums;
  const ClassList({required this.albums});

  factory ClassList.FromJson(List<dynamic> ParsedJson) {
    List<clas> albums;
    albums = ParsedJson.map((e) => clas.fromJson(e)).toList();
    return new ClassList(albums: albums);
  }
}

Future<ClassList> FetchAlbum_c() async {
  final keyApplicationId = 'evvicE1Cf12bFHsJNfp8gOKN9xHuhQZgr6afp9Z2';
  final keyCientKey = 'JKzv7uvgb5yVyqb4nYoC0ClICkrmuG0JmM34a6t2';
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  String ss = "";
  String ss2 = "";
  String ss3 = "";
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyCientKey, autoSendSessionId: true);
  QueryBuilder<ParseObject> q = QueryBuilder<ParseObject>(ParseObject("Class"));
  final ParseResponse a = await q.query();
  if (a.success && a.result != null) {
    ss = a.results.toString();

    ClassList task = ClassList.FromJson(jsonDecode(a.results.toString()));
    return task;
  } else {
    throw Exception("error");
  }
}
