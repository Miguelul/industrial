import 'package:flutter/cupertino.dart';

class BorderM {
  static Border borderSt(
      {Color color = const Color.fromARGB(0, 255, 255, 255),
      double width = 0,
      required int page,
      int estado = 0}) {
    if (page == 2 && estado == 1) {
      return Border.all(
        color: color,
        width: width,
      );
    } else {
      return Border.all(
        color: Color.fromARGB(0, 255, 255, 255),
        width: 0,
      );
    }
  }
}

class ColorM {
  static Color color(
      {required Color color,
      required int page,
      required int estado}) {
    if (page != 2 && estado == 1) {
      return color;
    } else {
      return const Color.fromARGB(255, 238, 238, 238);
    }
  }
}
