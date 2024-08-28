import 'package:flutter/cupertino.dart';

class Responsive {
  static getHeight(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return height;
  }

  static getWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }
}
