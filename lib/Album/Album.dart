import 'dart:io';

import 'package:attendance/Album/class_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Album/teacher_parse.dart';

import 'student_parse.dart';

class total {
  final StudntList s;
  final TeacherList tc;
  final ClassList cl;

  const total({
    required this.s,
    required this.tc,
    required this.cl,
  });

  factory total.FromJson(Map<String, dynamic> json) {
    return total(
      s: StudntList.FromJson(json['student']),
      tc: TeacherList.FromJson(json['teacher']),
      cl: ClassList.FromJson(json['class']),
    );
  }
}
