import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Album/class_parse.dart';
import '../Album/student_parse.dart';
import '../Album/teacher_parse.dart';

class element extends StatefulWidget {
  String text;
  var valid;
  /* dynamic k;
  AsyncSnapshot<ClassList> snapshot_c;
  AsyncSnapshot<StudntList> snapshot_s;
  AsyncSnapshot<TeacherList> snapshot_t;
  int j;*/

  element(this.text,
      this.valid /*,this.k,this.snapshot_t,this.snapshot_c,this.snapshot_s , this.j*/);

  @override
  State<element> createState() => _elementState();
}

class _elementState extends State<element> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: widget.valid,
      child: Column(
        children: [
          Container(
            width: _width * 0.9,
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            Text(
                              widget.text,
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.group),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
