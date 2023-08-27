import 'package:attendance/Provider/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../main.dart';

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

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    bool light = Provider.of<LightChanger>(context).light;
    var a = Provider.of<LightChanger>(context);
    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.center, child: Text("برنامه حضور و غیاب")),
        ),
        body: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 300,
            height: 100,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Switch(
                      activeColor: _lightTheme.focusColor,
                      inactiveThumbColor: _darkTheme.focusColor,
                      inactiveTrackColor: _darkTheme.focusColor,
                      value: light,
                      onChanged: (toggle) {
                        a.toggle();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "حالت روز / شب",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    light ? Icons.sunny : Icons.nightlight,
                    color:
                        light ? _lightTheme.focusColor : _darkTheme.focusColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
