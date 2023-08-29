import 'dart:convert';

import 'package:attendance/Screens/Signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../Screens/Login.dart';

class Teacher {
  String className;
  String objectId;
  String createdAt;
  String updatedAt;
  String email;
  String name;
  String phone;
  String password;
  List<String> clas;

  Teacher(
      {required this.className,
      required this.objectId,
      required this.createdAt,
      required this.updatedAt,
      required this.email,
      required this.name,
      required this.phone,
      required this.password,
      required this.clas});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        className: json['className'],
        objectId: json['objectId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
        password: json['password'],
        clas: json['clas'].cast<String>());
  }
}

class TeacherList {
  final List<Teacher> albums;
  const TeacherList({required this.albums});

  factory TeacherList.FromJson(List<dynamic> ParsedJson) {
    List<Teacher> albums;
    albums = ParsedJson.map((e) => Teacher.fromJson(e)).toList();
    return new TeacherList(albums: albums);
  }
}

Future<TeacherList> FetchAlbum() async {
  final keyApplicationId = 'evvicE1Cf12bFHsJNfp8gOKN9xHuhQZgr6afp9Z2';
  final keyCientKey = 'JKzv7uvgb5yVyqb4nYoC0ClICkrmuG0JmM34a6t2';
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  String ss = "";
  String ss2 = "";
  String ss3 = "";
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyCientKey, autoSendSessionId: true);
  QueryBuilder<ParseObject> q =
      QueryBuilder<ParseObject>(ParseObject("Teacher"));
  final ParseResponse a = await q.query();
  if (a.success && a.result != null) {
    ss = a.results.toString();
    TeacherList task = TeacherList.FromJson(jsonDecode(a.results.toString()));
    return task;
  } else {
    throw Exception("error");
  }
}
