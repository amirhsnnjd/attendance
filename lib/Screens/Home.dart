import 'package:attendance/Album/class_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Album/teacher_parse.dart';
import 'package:attendance/Material/ClassElement.dart';
import 'package:attendance/Screens/AddClass.dart';
import 'package:attendance/Screens/Manage.dart';
import 'package:attendance/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/light.dart';
import 'Login.dart';
import 'Setting.dart';
import 'Signup.dart';

void initial(SharedPreferences? login, int k) async {
  login = await SharedPreferences.getInstance();
  login.setInt("key", k);
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

class Home extends StatefulWidget {
  dynamic k;
  AsyncSnapshot<ClassList> snapshot_c;
  AsyncSnapshot<StudntList> snapshot_s;
  AsyncSnapshot<TeacherList> snapshot_t;
  Home(this.k, this.snapshot_t, this.snapshot_c, this.snapshot_s);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    bool light = Provider.of<LightChanger>(context).light;

    SharedPreferences? login;
    initial(login, widget.k);

    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: ((context) => AddClass(widget.k, widget.snapshot_t,
                    widget.snapshot_c, widget.snapshot_s))));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        drawer: NavigationDrawer(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(Icons.refresh),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => FutureBuilder<TeacherList>(
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return FutureBuilder<ClassList>(
                                  future: FetchAlbum_c(),
                                  builder: (context, snapshot_c) {
                                    if (snapshot_c.hasData) {
                                      return FutureBuilder<StudntList>(
                                        future: FetchAlbum_s(),
                                        builder: (context, snapshot_s) {
                                          if (snapshot_s.hasData) {
                                            return Home(widget.k, snapshot,
                                                snapshot_c, snapshot_s);
                                          } else if (snapshot_s.hasError) {
                                            return Text('${snapshot_s.error}');
                                          }
                                          return const SpinKitRotatingCircle(
                                            color: Colors.purple,
                                            size: 50.0,
                                          );
                                        },
                                      );
                                    } else if (snapshot_c.hasError) {
                                      return Text('${snapshot_c.error}');
                                    }
                                    return const SpinKitRotatingCircle(
                                      color: Colors.purple,
                                      size: 50.0,
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const SpinKitRotatingCircle(
                                color: Colors.purple,
                                size: 50.0,
                              );
                            },
                            future: FetchAlbum(),
                          ))));
                },
              ),
            )
          ],
          title: Align(alignment: Alignment.center, child: Text("صفحه اصلی")),
        ),
        body: ListView(
          children: [
            for (int i = 0; i <= widget.snapshot_c.data!.albums.length - 1; i++)
              if (widget.snapshot_c.data!.albums[i].teacher ==
                  widget.snapshot_t.data!.albums[widget.k].email)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      element(
                          widget.snapshot_c.data!.albums[i].name.toString() +
                              " گروه " +
                              widget.snapshot_c.data!.albums[i].group
                                  .toString(), () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => Manage(
                                i,
                                widget.snapshot_t,
                                widget.snapshot_c,
                                widget.snapshot_s,
                                widget.k))));
                      }),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.3,
                      )
                    ],
                  ),
                )
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
