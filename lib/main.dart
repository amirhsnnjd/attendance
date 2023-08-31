import 'dart:convert';

import 'package:attendance/Album/class_parse.dart';
import 'package:attendance/Album/student_parse.dart';
import 'package:attendance/Provider/light.dart';
import 'package:attendance/Album/teacher_parse.dart';
import 'package:attendance/Screens/Home.dart';
import 'package:attendance/Screens/Login.dart';
import 'package:attendance/Screens/Setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Signup.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = 'evvicE1Cf12bFHsJNfp8gOKN9xHuhQZgr6afp9Z2';
  final keyCientKey = 'JKzv7uvgb5yVyqb4nYoC0ClICkrmuG0JmM34a6t2';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyCientKey, autoSendSessionId: true);

  /*QueryBuilder<ParseObject> q = QueryBuilder<ParseObject>(ParseObject("Class"));
  final ParseResponse a = await q.query();
  if (a.success && a.result != null) {
    print(a.results);
  } else {
    throw Exception("error");
  }*/

  /*var aa = ParseObject('Student')..set("name", "hi");
  await aa.save();*/

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LightChanger>(
        create: (context) => LightChanger(),
      ),
    ],
    child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                breakpoints: [
                  ResponsiveBreakpoint.autoScale(350, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(640, name: TABLET),
                  ResponsiveBreakpoint.autoScale(800, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                ]),
        debugShowCheckedModeBanner: false,
        home: MyApp()),
  ));
}

void initial(SharedPreferences? login) async {
  login = await SharedPreferences.getInstance();
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences? login;
    initial(login);
    int? q = login?.getInt("key");

    //return LoginPage(false);
    if (q == -1 || q == null) {
      return LoginPage(false);
    } else {
      return FutureBuilder<TeacherList>(
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
                        return Home(q, snapshot, snapshot_c, snapshot_s);
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
      );
    }

    /* return FutureBuilder<TeacherList>(
      builder: (context, snapshot) {
        print("enter");
        if (snapshot.hasData) {
          
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
      future: FetchAlbum(),
    );*/

    ;
  }
}
