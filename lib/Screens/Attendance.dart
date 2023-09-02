import 'package:attendance/Screens/Manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../Album/class_parse.dart';
import '../Album/student_parse.dart';
import '../Album/teacher_parse.dart';
import '../Provider/light.dart';
import 'Login.dart';
import 'Setting.dart';

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

void SetAbsentee(String? object, String date) async {
  var firstObject2 = ParseObject('FirstClass')
    ..objectId = object
    ..setAdd("absentee", date);
  await firstObject2.save();
}

class Attendance extends StatefulWidget {
  int i;
  dynamic k;
  AsyncSnapshot<ClassList> snapshot_c;
  AsyncSnapshot<StudntList> snapshot_s;
  AsyncSnapshot<TeacherList> snapshot_t;
  Attendance(this.i, this.snapshot_c, this.snapshot_s, this.k, this.snapshot_t);
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<bool?> check = [];
  List<int> pos = [];
  bool create = true;
  Jalali j = Jalali.now();
  @override
  Widget build(BuildContext context) {
    if (create == true)
      for (int z = 0; z < widget.snapshot_s.data!.albums.length; z++) {
        if (widget.snapshot_s.data!.albums[z].clas ==
                widget.snapshot_c.data!.albums[widget.i].name &&
            widget.snapshot_s.data!.albums[z].group ==
                widget.snapshot_c.data!.albums[widget.i].group.toString()) {
          check.add(true);
          pos.add(z);
        }
      }
    bool light = Provider.of<LightChanger>(context).light;
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Align(alignment: Alignment.center, child: Text("حضور و غیاب")),
        ),
        body: ListView(children: [
          Container(
            child: Column(
              children: [
                Text(
                  "تاریخ : ${j.year}/${j.month}/${j.day}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.3,
                ),
                for (int x = 0; x < check.length; x++)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: check[x],
                              onChanged: (value) {
                                setState(() {
                                  create = false;
                                  check[x] = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: _width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    widget.snapshot_s.data!.albums[pos[x]].name
                                            .toString() +
                                        "(${widget.snapshot_s.data!.albums[pos[x]].idd})",
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.3,
                      )
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: SizedBox(
                    height: 50,
                    width: _width * 0.4,
                    child: ElevatedButton(
                        onPressed: () {
                          for (int y = 0; y < check.length; y++) {
                            if (check[y] == false) {
                              SetAbsentee(
                                  widget
                                      .snapshot_s.data!.albums[pos[y]].objectId,
                                  "${j.year}/${j.month}/${j.day}");
                            }
                          }
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      FutureBuilder<StudntList>(
                                        future: FetchAlbum_s(),
                                        builder: (context, snapshot2) {
                                          if (snapshot2.hasData) {
                                            return Manage(
                                                widget.i,
                                                widget.snapshot_t,
                                                widget.snapshot_c,
                                                snapshot2,
                                                widget.k);
                                          } else
                                            return const SpinKitRotatingCircle(
                                              color: Colors.purple,
                                              size: 50.0,
                                            );
                                        },
                                      ))));
                        },
                        child: Text(
                          " ثبت",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          )
        ]),
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
