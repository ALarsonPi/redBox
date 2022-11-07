import 'package:flutter/material.dart';

class ColorList extends ChangeNotifier {
  List<Color> currColorList;
  ColorList(this.currColorList);

  setNewColorList(List<Color> newColorList) {
    currColorList = newColorList;
  }
}
