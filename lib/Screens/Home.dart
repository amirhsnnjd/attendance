import 'package:attendance/Album/class_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Album/teacher_parse.dart';
import 'package:attendance/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    print("home");
    SharedPreferences? login;
    initial(login, widget.k);

    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Align(alignment: Alignment.center, child: Text("صفحه اصلی")),
        ),
        body: Column(
          children: [
            for (int i = 0; i <= widget.snapshot_c.data!.albums.length - 1; i++)
              if (widget.snapshot_c.data!.albums[i].teacher ==
                  widget.snapshot_t.data!.albums[widget.k].email)
                Text(widget.snapshot_c.data!.albums[i].name.toString())
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => Setting())));
            }))
      ],
    );
  } /*
*/
}
