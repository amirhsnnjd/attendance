import 'package:flutter/cupertino.dart';

class LightChanger with ChangeNotifier {
  bool light = true;
  void toggle() {
    light = !light;
    notifyListeners();
  }
}
