import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../Material/Input.dart';
import '../main.dart';

final _formkey = GlobalKey<FormState>();
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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.center, child: Text("برنامه حضور و غیاب")),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Switch(
                  value: light,
                  onChanged: (toggle) {
                    setState(() {
                      light = toggle;
                    });
                  }),
            ),
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
                            else
                              return null;
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
                                RegExp(r'^[0-9]+$').hasMatch(value))
                              return ('لطفا شماره را درست وارد کنید');
                            else
                              return null;
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
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value))
                              return ('لطفا ایمیل را درست وارد کنید');
                            else
                              return null;
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
                    Container(
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
                              validator: ((value) {
                                if (value!.isEmpty || value == null)
                                  return ('لطفا رمز را وارد کنید');
                                else
                                  return null;
                              }),
                              style: TextStyle(
                                height: 1,
                              ),
                              decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: "رمز عبور ",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: light
                                            ? _lightTheme.focusColor
                                            : _darkTheme.focusColor,
                                        width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: light
                                            ? _lightTheme.primaryColor
                                            : _darkTheme.primaryColor,
                                        width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  prefixIcon: Icon(Icons.password),
                                  errorStyle: TextStyle(
                                      color: Colors.red, fontSize: 13),
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "حساب کاربری ندارید ؟",
                            style: TextStyle(fontSize: 17),
                          )),
                    ),
                  ],
                ),
                key: _formkey,
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: Row(children: [
                SizedBox(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                      onPressed: () =>
                          {if (_formkey.currentState!.validate()) {}},
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
                      child: Text("prev")),
                ),
                SizedBox(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () =>
                        {if (_formkey.currentState!.validate()) {}},
                    style: ElevatedButton.styleFrom(
                        primary: light
                            ? _lightTheme.focusColor
                            : _darkTheme.focusColor),
                    child: Text("Next"),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
