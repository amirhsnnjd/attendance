import 'package:attendance/Material/Input.dart';
import 'package:attendance/Screens/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../Provider/light.dart';
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

final _formkey2 = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _passwordVisible = false;
String passw1 = "";
String em = "";

class _LoginPageState extends State<LoginPage> {
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
            title: Align(alignment: Alignment.center, child: Text("ورود")),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    child: Form(
                      child: Column(
                        children: [
                          Input(((value) {
                            if (value!.isEmpty ||
                                value == null ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value))
                              return ('لطفا ایمیل را درست وارد کنید');
                            else {
                              em = value;
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
                                    obscureText: !_passwordVisible,
                                    validator: ((value) {
                                      if (value!.isEmpty || value == null)
                                        return ('لطفا رمز را وارد کنید');
                                      else {
                                        passw1 = value;
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
                                        hintTextDirection: TextDirection.rtl,
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
                                              color: Colors.red, width: 2.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0),
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
                                            color: Colors.red, fontSize: 13),
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                              ],
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
                                    onPressed: () => {
                                      if (_formkey2.currentState!.validate())
                                        {print(name), print(phone)}
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: light
                                            ? _lightTheme.focusColor
                                            : _darkTheme.focusColor),
                                    child: Text("ورود",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                              ]),
                            ),
                          )
                        ],
                      ),
                      key: _formkey2,
                    ),
                  )
                ],
              )),
        ));
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
            enabled: false,
            leading: Icon(
              Icons.home_outlined,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('صفحه اصلی', style: TextStyle(fontSize: 18)),
            onTap: (() {})),
        ListTile(
            leading: Icon(
              Icons.group_add_outlined,
              color: light ? _lightTheme.focusColor : _darkTheme.focusColor,
            ),
            title: const Text('  ایجاد حساب کاربری',
                style: TextStyle(fontSize: 18)),
            onTap: (() {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((context) => Signup())));
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
