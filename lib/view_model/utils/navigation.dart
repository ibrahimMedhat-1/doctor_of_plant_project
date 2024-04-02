import 'package:flutter/material.dart';

class Navigation {
  static void push(context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pushAndRemove(context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  static void pushAndReplacement(context, Widget screen) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  static void pop(context) {
    Navigator.pop(context);
  }
}
