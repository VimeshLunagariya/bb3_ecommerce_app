// ignore_for_file: comment_references

import 'package:bb3_ecommerce_app/utilities/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// All the global variables used in the application are defined in this class.
class VariableUtilities {
  /// we can use screen size in application using this global variable.
  static late Size screenSize;

  /// this is the instance of shared preferences.
  /// this will be used to access preference instance in application.
  static late SharedPreferences preferences;

  /// we can use multiple theme using this variable.
  /// we can switch between themes by assigning new theme in this class.
  /// we can access all the colors using in the application by this variable.
  static late ThemeBase theme;
}
