import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import '../Album/class_parse.dart';
import '../Album/student_parse.dart';
import '../Album/teacher_parse.dart';
import '../Provider/light.dart';
import 'Home.dart';
import 'Login.dart';
import 'Setting.dart';

void RemoveClass(String? object) async {
  var firstObject = ParseObject('Class')..objectId = object;
  await firstObject.delete();
}

void RemoveStudent(String? object) async {
  var firstObject = ParseObject('FirstClass')..objectId = object;
  await firstObject.delete();
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

class Manage extends StatefulWidget {
  int i;
  dynamic k;
  AsyncSnapshot<ClassList> snapshot_c;
  AsyncSnapshot<StudntList> snapshot_s;
  AsyncSnapshot<TeacherList> snapshot_t;
  Manage(this.i, this.snapshot_t, this.snapshot_c, this.snapshot_s, this.k);

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    bool light = Provider.of<LightChanger>(context).light;
    double _width = MediaQuery.of(context).size.width;
    int j = 0;
    for (int q = 0; q < widget.snapshot_s.data!.albums.length; q++) {
      if (widget.snapshot_s.data!.albums[q].clas ==
          widget.snapshot_c.data!.albums[widget.i].name) {
        j++;
      }
    }
    /**/

    ;
    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Align(alignment: Alignment.center, child: Text("مدیریت کلاس")),
        ),
        body: ListView(
          children: [
            Column(children: [
              Container(
                  width: _width * 0.95,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "نام کلاس :   " +
                                        widget.snapshot_c.data!.albums[widget.i]
                                            .name
                                            .toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "\r\nگروه کلاس :   " +
                                        widget.snapshot_c.data!.albums[widget.i]
                                            .group
                                            .toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "\r\nتعداد دانشجو :   " + j.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 48.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 50,
                                              width: _width * 0.40,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "انجام حضور و غیاب",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: _width * 0.45,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                "وضعیت حضور و غیاب",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 70.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onLongPress: () {
                                              RemoveClass(widget
                                                  .snapshot_c
                                                  .data!
                                                  .albums[widget.i]
                                                  .objectId);
                                              for (int s = 0;
                                                  s <
                                                      widget.snapshot_s.data!
                                                          .albums.length;
                                                  s++)
                                                if (widget.snapshot_s.data!
                                                            .albums[s].clas ==
                                                        widget
                                                            .snapshot_c
                                                            .data!
                                                            .albums[widget.i]
                                                            .name &&
                                                    widget.snapshot_s.data!
                                                            .albums[s].group ==
                                                        widget
                                                            .snapshot_c
                                                            .data!
                                                            .albums[widget.i]
                                                            .group
                                                            .toString()) {
                                                  RemoveStudent(widget
                                                      .snapshot_s
                                                      .data!
                                                      .albums[s]
                                                      .objectId);
                                                }
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder:
                                                          ((context) =>
                                                              FutureBuilder<
                                                                  TeacherList>(
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    return FutureBuilder<
                                                                        ClassList>(
                                                                      future:
                                                                          FetchAlbum_c(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot_c) {
                                                                        if (snapshot_c
                                                                            .hasData) {
                                                                          return FutureBuilder<
                                                                              StudntList>(
                                                                            future:
                                                                                FetchAlbum_s(),
                                                                            builder:
                                                                                (context, snapshot_s) {
                                                                              if (snapshot_s.hasData) {
                                                                                return Home(widget.k, snapshot, snapshot_c, snapshot_s);
                                                                              } else if (snapshot_s.hasError) {
                                                                                return Text('${snapshot_s.error}');
                                                                              }
                                                                              return const SpinKitRotatingCircle(
                                                                                color: Colors.purple,
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
                                                                          color:
                                                                              Colors.purple,
                                                                          size:
                                                                              50.0,
                                                                        );
                                                                      },
                                                                    );
                                                                  } else if (snapshot
                                                                      .hasError) {
                                                                    return Text(
                                                                        '${snapshot.error}');
                                                                  }
                                                                  return const SpinKitRotatingCircle(
                                                                    color: Colors
                                                                        .purple,
                                                                    size: 50.0,
                                                                  );
                                                                },
                                                                future:
                                                                    FetchAlbum(),
                                                              ))));
                                            },
                                            child: Container(
                                              width: _width * 0.6,
                                              height: 60,
                                              color: Colors.red,
                                              child: Center(
                                                  child: Text(
                                                "برای حذف کلاس نگه دارید",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ))
            ])
          ],
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
