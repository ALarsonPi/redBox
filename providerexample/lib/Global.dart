import 'package:flutter/material.dart';

class Global {
  static List<Color> colorListEasy = List.empty(growable: true);
  static List<Color> colorListMedium = List.empty(growable: true);
  static List<Color> colorListHard = List.empty(growable: true);

  static List<String> colorNames = List.empty(growable: true);

  static void fillColorNamesList() {
    colorNames.add("Green");
    colorNames.add("Red");
    colorNames.add("Blue");
    colorNames.add("Purple");
    colorNames.add("Orange");
    colorNames.add("Cyan");
    colorNames.add("Teal");
    colorNames.add("Beige");
    colorNames.add("Yellow");
  }

  static void fillColorListEasy() {
    for (int i = 1; i < 10; i++) {
      colorListEasy.add(Colors.green[i * 100] as Color);
    }
  }

  static void fillColorListMedium() {
    for (int i = 1; i < 10; i++) {
      colorListMedium.add(Colors.green[i * 100] as Color);
      colorListMedium.add(Colors.teal[i * 100] as Color);
    }
  }

  static void fillColorListHard() {
    for (int i = 1; i < 10; i++) {
      colorListHard.add(Colors.green[i * 100] as Color);
      colorListHard.add(Colors.teal[i * 100] as Color);
      colorListHard.add(Colors.purple[i * 100] as Color);
      colorListHard.add(Colors.blue[i * 100] as Color);
      colorListHard.add(Colors.yellow[i * 100] as Color);
    }
  }
}
