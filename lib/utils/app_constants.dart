import 'dart:ui';
import 'package:flutter/material.dart';

class AppConstants {
  // UI strings
  static const String kServerError = 'Server failure, please check back';

  // text styles
  static const TextStyle kTextStyleDefault = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle kTextStyleTitle = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
  );

  // UI styles
  static const kDefaultDivider = Divider(
    height: 10,
    color: Colors.blue,
  );
  static const kGroceryListDivider = Divider(
    height: 10,
    color: Colors.black26,
  );
}
