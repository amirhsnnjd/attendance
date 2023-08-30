import 'dart:core';

import 'package:attendance/Material/Input.dart';
import 'package:attendance/Screens/Setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../Album/class_parse.dart';
import '../Album/student_parse.dart';
import '../Album/teacher_parse.dart';
import '../Provider/light.dart';
import 'Login.dart';

void c(String name, int group, String teacher) async {
  var firstObject2 = ParseObject('Class')
    ..set("name", name)
    ..set("group", group)
    ..set("teacher", teacher)
    ..setAdd("student", "khali");
  await firstObject2.save();
}

ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromARGB(255, 250, 250, 250),
    primarySwatch: Colors.amber,
    focusColor: Colors.amber,
    accentColor: Colors.amber);

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color.fromARGB(255, 83, 84, 85),
  focusColor: Colors.purple,
  primarySwatch: Colors.purple,
  accentColor: Colors.purple,
);

class AddClass extends StatefulWidget {
  dynamic k;
  AsyncSnapshot<ClassList> snapshot_c;
  AsyncSnapshot<StudntList> snapshot_s;
  AsyncSnapshot<TeacherList> snapshot_t;

  AddClass(this.k, this.snapshot_t, this.snapshot_c, this.snapshot_s);
  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  String classname = "";
  int classgroup = 0;
  int StudentNum = 0;
  List<String> StudentNameList = [];
  List<String> StudentIdList = [];
  final _formkey3 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool light = Provider.of<LightChanger>(context).light;
    double _width = MediaQuery.of(context).size.width;

    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Align(alignment: Alignment.center, child: Text("ایجاد کلاس")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                child: Form(
                    key: _formkey3,
                    child: Column(
                      children: [
                        Input(((value) {
                          if (value!.isEmpty || value == null)
                            return ('لطفا نام را درست وارد کنید');
                          else {
                            classname = value;
                            return null;
                          }
                        }),
                            _width * 0.95,
                            1,
                            "پروژه پایانی",
                            "نام درس",
                            Icon(Icons.menu_book),
                            light,
                            _lightTheme,
                            _darkTheme),
                        Input(((value) {
                          if (value!.isEmpty || value == null)
                            return ('لطفا گروه را درست وارد کنید');
                          else {
                            classgroup = int.parse(value);
                            return null;
                          }
                        }),
                            _width * 0.95,
                            1,
                            "01",
                            "گروه درس",
                            Icon(Icons.format_list_numbered_rounded),
                            light,
                            _lightTheme,
                            _darkTheme),
                        Input(((value) {
                          if (value!.isEmpty ||
                              value == null ||
                              !RegExp(r'^[0-9]+$').hasMatch(value))
                            return ('لطفا یک عدد وارد کنید');
                          else {
                            StudentNum = int.parse(value);
                            return null;
                          }
                        }),
                            _width * 0.95,
                            1,
                            "10",
                            "تعداد دانشجو",
                            Icon(Icons.format_list_numbered_rounded),
                            light,
                            _lightTheme,
                            _darkTheme),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: SizedBox(
                            height: 50,
                            width: _width * 0.4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: light
                                      ? _lightTheme.focusColor
                                      : _darkTheme.focusColor),
                              child: Text("صفحه بعد",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                if (_formkey3.currentState!.validate()) {
                                  c(
                                      classname.toString(),
                                      classgroup,
                                      widget.snapshot_t.data!.albums[widget.k]
                                          .email
                                          .toString());
                                  print("done");
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) {
    bool light = Provider.of<LightChanger>(context).light;
    return Column(
      children: [
        ListTile(
            enabled: false,
            leading: Icon(
              Icons.home_outlined,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('صفحه اصلی', style: TextStyle(fontSize: 18)),
            onTap: (() {})),
        ListTile(
            enabled: true,
            leading: Icon(
              Icons.exit_to_app,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('خروج', style: TextStyle(fontSize: 18)),
            onTap: (() {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => LoginPage(false))));
            })),
        ListTile(
            leading: Icon(
              Icons.settings,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('تنظیمات', style: TextStyle(fontSize: 18)),
            onTap: (() {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((context) => Setting())));
            }))
      ],
    );
  } /*
*/
}
