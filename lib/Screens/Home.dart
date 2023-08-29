import 'package:attendance/Album/class_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Album/teacher_parse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  AsyncSnapshot<ClassList> snapshot_c;
  AsyncSnapshot<StudntList> snapshot_s;
  AsyncSnapshot<TeacherList> snapshot_t;
  Home(this.snapshot_t, this.snapshot_c, this.snapshot_s);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text(widget.snapshot_c.data!.albums[0].name.toString()),
      ),
    );
  }
}
