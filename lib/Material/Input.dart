import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../main.dart';

class Input extends StatelessWidget {
  Icon icon;
  var valid;
  String hint;
  String text;
  bool light;
  ThemeData lightTheme;
  ThemeData darkTheme;
  double wid;
  double h;
  Input(this.valid, this.wid, this.h, this.hint, this.text, this.icon,
      this.light, this.lightTheme, this.darkTheme);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: wid,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: valid,
              style: TextStyle(
                height: h,
              ),
              decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText: hint,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: light
                            ? lightTheme.focusColor
                            : darkTheme.focusColor,
                        width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: light
                            ? lightTheme.primaryColor
                            : darkTheme.primaryColor,
                        width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  prefixIcon: icon,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 13),
                  hintStyle: TextStyle(
                    fontSize: 15,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
