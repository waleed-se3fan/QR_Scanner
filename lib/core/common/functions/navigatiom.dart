import 'package:flutter/material.dart';

class Navigations {
  static void navigateTo(context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void navigateAndFinish(context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
