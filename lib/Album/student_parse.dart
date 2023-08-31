import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class st {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? group;
  String? idd;
  List<String>? absentee;
  String? clas;
  st(
      {required className,
      required objectId,
      required createdAt,
      required updatedAt,
      required name,
      required absentee,
      required idd,
      required clas,
      required group});

  st.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    group = json['group'];
    idd = json['idd'];
    absentee = json['absentee'].cast<String>();
    clas = json['class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['className'] = this.className;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['name'] = this.name;
    data['group'] = this.group;
    data['idd'] = this.idd;
    data['absentee'] = this.absentee;
    data['class'] = this.clas;
    return data;
  }
}
/*class st {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? name;
  List<String>? absentee;
  String? idd;
  String? clas;
  String? group;

  st(
      {required className,
      required objectId,
      required createdAt,
      required updatedAt,
      required name,
      required absentee,
      required idd,
      required clas,
      required group});

  factory st.fromJson(Map<String, dynamic> json) {
    return st(
        className: json['className'],
        objectId: json['objectId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        name: json['name'],
        absentee: json['absentee'].cast<String>(),
        idd: json['idd'],
        clas: json['class'],
        group: json['group']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['className'] = this.className;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['name'] = this.name;
    data['absentee'] = this.absentee;
    data['idd'] = this.idd;
    data['class'] = this.clas;
    data['group'] = this.group;
    return data;
  }
}*/

class StudntList {
  final List<st> albums;
  const StudntList({required this.albums});

  factory StudntList.FromJson(List<dynamic> ParsedJson) {
    List<st> albums;
    albums = ParsedJson.map((e) => st.fromJson(e)).toList();
    return new StudntList(albums: albums);
  }
}

Future<StudntList> FetchAlbum_s() async {
  final keyApplicationId = 'evvicE1Cf12bFHsJNfp8gOKN9xHuhQZgr6afp9Z2';
  final keyCientKey = 'JKzv7uvgb5yVyqb4nYoC0ClICkrmuG0JmM34a6t2';
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyCientKey, autoSendSessionId: true);
  QueryBuilder<ParseObject> q =
      QueryBuilder<ParseObject>(ParseObject("FirstClass"));
  final ParseResponse a = await q.query();
  if (a.success && a.result != null) {
    StudntList task = StudntList.FromJson(jsonDecode(a.results.toString()));
    return task;
  } else {
    throw Exception("error");
  }
}
