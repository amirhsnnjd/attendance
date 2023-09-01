import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../Album/class_parse.dart';
import '../Album/student_parse.dart';
import '../Provider/light.dart';
import 'Login.dart';
import 'Setting.dart';

String conv(List<String> s) {
  String j = "";
  for (int u = 1; u < s.length; u++) {
    j += s[u] + "\r\n";
  }
  return j;
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

class Item {
  final String? header;
  final String id;
  final int ab;
  final String body;
  bool isExpanded;
  Item({
    required this.header,
    required this.id,
    required this.ab,
    required this.body,
    this.isExpanded = false,
  });
}

class Absentee extends StatefulWidget {
  int i;
  AsyncSnapshot<ClassList> snapshot_c;
  AsyncSnapshot<StudntList> snapshot_s;
  Absentee(this.i, this.snapshot_c, this.snapshot_s);

  @override
  State<Absentee> createState() => _AbsenteeState();
}

class _AbsenteeState extends State<Absentee> {
  List<Item> items = [];
  @override
  Widget build(BuildContext context) {
    if (items.length == 0)
      for (int s = 0; s < widget.snapshot_s.data!.albums.length; s++)
        if (widget.snapshot_s.data!.albums[s].clas ==
                widget.snapshot_c.data!.albums[widget.i].name &&
            widget.snapshot_s.data!.albums[s].group ==
                widget.snapshot_c.data!.albums[widget.i].group.toString()) {
          items.add(Item(
              ab: (widget.snapshot_s.data!.albums[s].absentee!.length as int) -
                  1,
              header: widget.snapshot_s.data!.albums[s].name,
              id: widget.snapshot_s.data!.albums[s].idd.toString(),
              body: conv(
                  widget.snapshot_s.data!.albums[s].absentee as List<String>)));
        }
    bool light = Provider.of<LightChanger>(context).light;
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: NavigationDrawer(),
          appBar: AppBar(
            title:
                Align(alignment: Alignment.center, child: Text("وضعیت کلاس")),
          ),
          body: SingleChildScrollView(
            child: ExpansionPanelList(
                expansionCallback: (index, isExpanded) {
                  setState(() {
                    items[index].isExpanded = !isExpanded;
                    print(items[index].isExpanded);
                  });
                },
                children: [
                  for (int c = 0; c < items.length; c++)
                    ExpansionPanel(
                        canTapOnHeader: true,
                        isExpanded: items[c].isExpanded,
                        headerBuilder: (context, isExpanded) => Text(
                              items[c].header.toString() +
                                  "(" +
                                  items[c].id +
                                  ")  " +
                                  items[c].ab.toString() +
                                  "   " +
                                  "غیبت",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                        body: Text(
                          items[c].body,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ))
                ]),
          )),
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
