import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class StudentElement extends StatelessWidget {
  int i;
  var valid;
  var valid2;
  double h;
  bool light;
  ThemeData lightTheme;
  ThemeData darkTheme;
  double wid;
  StudentElement(this.i, this.valid, this.valid2, this.h, this.light,
      this.darkTheme, this.lightTheme, this.wid);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "دانشجو شماره " + i.toString(),
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
                  hintText: "نام دانشجو",
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
                  prefixIcon: Icon(Icons.person),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 13),
                  hintStyle: TextStyle(
                    fontSize: 15,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: valid2,
              style: TextStyle(
                height: h,
              ),
              decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText: "شماره دانشحویی",
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
                  prefixIcon: Icon(Icons.numbers_outlined),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 13),
                  hintStyle: TextStyle(
                    fontSize: 15,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
