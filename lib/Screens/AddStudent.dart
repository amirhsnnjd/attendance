import 'package:attendance/Material/StudentElement.dart';
import 'package:attendance/Provider/light.dart';
import 'package:attendance/Screens/AddClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import '../Album/class_parse.dart';
import '../Album/student_parse.dart';
import '../Album/teacher_parse.dart';
import 'Home.dart';
import 'Login.dart';
import 'Setting.dart';

void s(String name, String group, String id, String Class) async {
  var firstObject2 = ParseObject('FirstClass')
    ..set("name", name)
    ..set("group", group)
    ..set("idd", id)
    ..set("class", Class)
    ..setAdd("absentee", "khali");
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

class AddStudent extends StatefulWidget {
  dynamic k;
  String classname1;
  int classgroup1;
  int studentnum1;
  AddStudent(this.k, this.classname1, this.classgroup1, this.studentnum1);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formkey4 = GlobalKey<FormState>();
  List<String> StudentNameList = [];
  List<String> StudentIdList = [];
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
            title: Align(
                alignment: Alignment.center, child: Text("اطلاعات دانشجو ")),
          ),
          body: ListView(
            children: [
              Container(
                child: Form(
                  key: _formkey4,
                  child: Column(
                    children: [
                      for (int i = 1; i <= widget.studentnum1; i++)
                        StudentElement(i, ((value) {
                          if (value!.isEmpty || value == null)
                            return ('لطفا نام را درست وارد کنید');
                          else {
                            StudentNameList.add(value);
                            return null;
                          }
                        }), ((value) {
                          if (value!.isEmpty ||
                              value == null ||
                              !RegExp(r'^[0-9]+$').hasMatch(value))
                            return ('لطفا عدد را درست وارد کنید');
                          else {
                            StudentIdList.add(value);
                            return null;
                          }
                        }), 1, light, _darkTheme, _lightTheme, _width * 0.95),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SizedBox(
                          height: 50,
                          width: _width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: light
                                    ? _lightTheme.focusColor
                                    : _darkTheme.focusColor),
                            child: Text(" ثبت کلاس",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              if (_formkey4.currentState!.validate()) {
                                for (int j = 0; j < widget.studentnum1; j++) {
                                  s(
                                      StudentNameList[j],
                                      widget.classgroup1.toString(),
                                      StudentIdList[j],
                                      widget.classname1);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          FutureBuilder<TeacherList>(
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return FutureBuilder<ClassList>(
                                                  future: FetchAlbum_c(),
                                                  builder:
                                                      (context, snapshot_c) {
                                                    if (snapshot_c.hasData) {
                                                      return FutureBuilder<
                                                          StudntList>(
                                                        future: FetchAlbum_s(),
                                                        builder: (context,
                                                            snapshot_s) {
                                                          if (snapshot_s
                                                              .hasData) {
                                                            return Home(
                                                                widget.k,
                                                                snapshot,
                                                                snapshot_c,
                                                                snapshot_s);
                                                          } else if (snapshot_s
                                                              .hasError) {
                                                            return Text(
                                                                '${snapshot_s.error}');
                                                          }
                                                          return const SpinKitRotatingCircle(
                                                            color:
                                                                Colors.purple,
                                                            size: 50.0,
                                                          );
                                                        },
                                                      );
                                                    } else if (snapshot_c
                                                        .hasError) {
                                                      return Text(
                                                          '${snapshot_c.error}');
                                                    }
                                                    return const SpinKitRotatingCircle(
                                                      color: Colors.purple,
                                                      size: 50.0,
                                                    );
                                                  },
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    '${snapshot.error}');
                                              }
                                              return const SpinKitRotatingCircle(
                                                color: Colors.purple,
                                                size: 50.0,
                                              );
                                            },
                                            future: FetchAlbum(),
                                          ))));
                                }
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
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
