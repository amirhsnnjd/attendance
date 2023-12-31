import 'package:attendance/Screens/Login.dart';
import 'package:attendance/Screens/Setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

import '../Album/teacher_parse.dart';
import '../Material/Input.dart';
import '../Provider/light.dart';
import '../main.dart';
import 'Home.dart';

void a(String? name, String? email, String? pass1, String? phone) async {
  var firstObject = ParseObject('Teacher')
    ..set("name", name)
    ..set("email", email)
    ..set("password", pass1)
    ..set("phone", phone)
    ..setAdd("clas", "khali");
  await firstObject.save();
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

class Signup extends StatefulWidget {
  bool er;
  Signup(this.er);
  @override
  State<Signup> createState() => _SignupState();
}

String? name = null;
String? phone = null;
String? email = null;
String? pass1 = null;
String? pass2 = null;
bool _passwordVisible = false;

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool light = Provider.of<LightChanger>(context).light;
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: Align(alignment: Alignment.center, child: Text("ثبت نام")),
          centerTitle: true,
          //automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                child: Form(
                  child: Column(
                    children: [
                      ResponsiveRowColumn(
                        rowPadding: EdgeInsets.fromLTRB(30, 15, 30, 30),
                        rowMainAxisAlignment: MainAxisAlignment.center,
                        layout:
                            ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                                ? ResponsiveRowColumnType.COLUMN
                                : ResponsiveRowColumnType.ROW,
                        children: [
                          ResponsiveRowColumnItem(
                            rowFlex: 1,
                            child: Input(((value) {
                              if (value!.isEmpty || value == null)
                                return ('لطفا نام خود را وارد کنید');
                              else {
                                name = value;
                                return null;
                              }
                            }),
                                _width * 0.95,
                                1,
                                "نام و نام خانوادگی",
                                "نام و نام خانوادگی",
                                Icon(Icons.person),
                                light,
                                _lightTheme,
                                _darkTheme),
                          ),
                          ResponsiveRowColumnItem(
                            rowFlex: 1,
                            child: Input(((value) {
                              if (value!.isEmpty ||
                                  value == null ||
                                  !RegExp(r'^\d{11}$').hasMatch(value))
                                return ('لطفا شماره را درست وارد کنید');
                              else {
                                phone = value;
                                return null;
                              }
                            }),
                                _width * 0.95,
                                1,
                                "09123456789",
                                "شماره موبایل",
                                Icon(Icons.phone),
                                light,
                                _lightTheme,
                                _darkTheme),
                          )
                        ],
                      ),
                      ResponsiveRowColumn(
                        rowPadding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                        layout:
                            ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                                ? ResponsiveRowColumnType.COLUMN
                                : ResponsiveRowColumnType.ROW,
                        children: [
                          ResponsiveRowColumnItem(
                            rowFlex: 2,
                            child: Input(((value) {
                              if (value!.isEmpty ||
                                  value == null ||
                                  !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                      .hasMatch(value))
                                return ('لطفا ایمیل را درست وارد کنید');
                              else {
                                email = value;
                                return null;
                              }
                            }),
                                _width * 0.95,
                                1,
                                "abcd@abcd.com",
                                "آدرس ایمیل",
                                Icon(Icons.email),
                                light,
                                _lightTheme,
                                _darkTheme),
                          ),
                        ],
                      ),
                      ResponsiveRowColumn(
                          rowPadding: EdgeInsets.fromLTRB(30, 15, 30, 30),
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          layout: ResponsiveWrapper.of(context)
                                  .isSmallerThan(TABLET)
                              ? ResponsiveRowColumnType.COLUMN
                              : ResponsiveRowColumnType.ROW,
                          children: [
                            ResponsiveRowColumnItem(
                              rowFlex: 1,
                              child: Container(
                                width: _width * 0.95,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "رمزعبور",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        obscureText: !_passwordVisible,
                                        validator: ((value) {
                                          if (value!.isEmpty ||
                                              value == null ||
                                              !RegExp(r"^(?=.*[A-Z]).{8,}$")
                                                  .hasMatch(value))
                                            return ('رمز باید شامل حداقل 8 کاراکتر و یک حرف بزرگ باشد');
                                          else {
                                            pass1 = value;
                                            return null;
                                          }
                                        }),
                                        style: TextStyle(
                                          height: 1,
                                        ),
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.password,
                                            ),
                                            hintTextDirection:
                                                TextDirection.rtl,
                                            hintText: "رمز عبور ",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: light
                                                      ? _lightTheme.focusColor
                                                      : _darkTheme.focusColor,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: light
                                                      ? _lightTheme.primaryColor
                                                      : _darkTheme.primaryColor,
                                                  width: 2.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: light
                                                    ? _lightTheme.focusColor
                                                    : _darkTheme.focusColor,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                            errorStyle: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13),
                                            hintStyle: TextStyle(
                                              fontSize: 15,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              rowFlex: 1,
                              child: Container(
                                width: _width * 0.95,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "تکرار رمزعبور",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        obscureText: !_passwordVisible,
                                        validator: ((value) {
                                          if (value!.isEmpty || value == null)
                                            return ('لطفا  رمز را وارد کنید');
                                          else if (value != pass1) {
                                            return ("رمز یکسان نیست! دقت کنید");
                                          } else {
                                            return null;
                                          }
                                        }),
                                        style: TextStyle(
                                          height: 1,
                                        ),
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.password,
                                            ),
                                            hintTextDirection:
                                                TextDirection.rtl,
                                            hintText: "رمز عبور ",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: light
                                                      ? _lightTheme.focusColor
                                                      : _darkTheme.focusColor,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: light
                                                      ? _lightTheme.primaryColor
                                                      : _darkTheme.primaryColor,
                                                  width: 2.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: light
                                                    ? _lightTheme.focusColor
                                                    : _darkTheme.focusColor,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                            errorStyle: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13),
                                            hintStyle: TextStyle(
                                              fontSize: 15,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          LoginPage(false))));
                            },
                            child: Text(
                              "از قبل حساب کاربری دارید ؟",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Visibility(
                          visible: widget.er,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Center(
                                child: Container(
                                    width: 150,
                                    child: Text(
                                      "ایمیل تکراری است",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))),
                          )),
                    ],
                  ),
                  key: _formkey,
                ),
              ),
              Center(
                child: Container(
                  width: _width * 0.4,
                  height: 150,
                  child: Row(children: [
                    SizedBox(
                      height: 50,
                      width: _width * 0.4,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        FutureBuilder<TeacherList>(
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if (snapshot
                                                      .data!.albums[0].email ==
                                                  email) {
                                                return Signup(true);
                                              } else {
                                                a(name, email, pass1, phone);
                                                return LoginPage(false);
                                              }
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
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: light
                                ? _lightTheme.focusColor
                                : _darkTheme.focusColor),
                        child: Text("ثبت نام",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

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
            enabled: true,
            leading: Icon(
              Icons.home_outlined,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('صفحه اصلی', style: TextStyle(fontSize: 18)),
            onTap: (() {})),
        ListTile(
            leading: Icon(
              Icons.vpn_key_rounded,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('  ورود به حساب کاربری',
                style: TextStyle(fontSize: 18)),
            onTap: (() {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => LoginPage(false))));
            })),
        ListTile(
            enabled: false,
            leading: Icon(
              Icons.group_add_outlined,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('  ایجاد حساب کاربری',
                style: TextStyle(fontSize: 18)),
            onTap: (() {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => Signup(false))));
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
