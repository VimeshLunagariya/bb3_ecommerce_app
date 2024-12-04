// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// FontUtilities is main base class for all the styles of fonts used.
/// you can directly change the font styles in this file.
/// so, all the fonts used in application will be changed.

class FontUtilities {
  /// FONTSTYLE FOR FONT SIZE 6
  static TextStyle h6({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 6.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 8
  static TextStyle h8({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 8.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 9
  static TextStyle h9({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 9.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 10
  static TextStyle h10({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 10.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 11
  static TextStyle h11({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 11.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 12
  static TextStyle h12({
    Color fontColor = Colors.black,
    TextDecoration? decoration,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 12.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 13
  static TextStyle h13({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 13.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 14
  static TextStyle h14({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 14.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 15
  static TextStyle h15({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 15.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 16
  static TextStyle h16({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 16.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 18
  static TextStyle h18({
    Color fontColor = Colors.black,
    TextDecoration? decoration,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 18.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 20
  static TextStyle h20({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 20.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 22
  static TextStyle h22({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 22.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 23
  static TextStyle h23({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 23.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 24
  static TextStyle h24({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 24.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 26
  static TextStyle h26({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 26.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 28
  static TextStyle h28({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 28.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 30
  static TextStyle h30({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 30.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 32
  static TextStyle h32({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 32.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 34
  static TextStyle h34({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 34.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 36
  static TextStyle h36({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 36.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 38
  static TextStyle h38({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 38.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 40
  static TextStyle h40({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 40.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 45
  static TextStyle h45({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 45.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 50
  static TextStyle h50({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 50.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 55
  static TextStyle h55({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 55.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 60
  static TextStyle h60({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 60.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 65
  static TextStyle h65({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 65.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 70
  static TextStyle h70({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 70.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 75
  static TextStyle h75({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 75.h, letterSpacing: letterSpacing, decoration: decoration));
  }

  /// FONTSTYLE FOR FONT SIZE 80
  static TextStyle h80({
    Color fontColor = Colors.black,
    FWT fontWeight = FWT.regular,
    String fontFamily = 'Outfit',
    TextDecoration? decoration,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.getFont(fontFamily, textStyle: TextStyle(color: fontColor, fontWeight: getFontWeight(fontWeight), fontSize: 80.h, letterSpacing: letterSpacing, decoration: decoration));
  }
}

/// these are the most commonly used fontweight for mobile application.
enum FF {
  /// source San pro
  sourceSansPro,

  ///Playfair display
  payFairDisplay,
}

/// these are the most commonly used fontweight for mobile application.
enum FWT {
  /// FontWeight -> 900
  extraBold,

  /// FontWeight -> 800
  black,

  /// FontWeight -> 700
  bold,

  /// FontWeight -> 600
  semiBold,

  /// FontWeight -> 500
  medium,

  /// FontWeight -> 400
  regular,

  /// FontWeight -> 200
  light,
}

/// THIS FUNCTION IS USED TO SET FONT WEIGHT ACCORDING TO SELECTED ENUM...
FontWeight getFontWeight(FWT fwt) {
  switch (fwt) {
    case FWT.light:
      return FontWeight.w200;
    case FWT.regular:
      return FontWeight.w400;
    case FWT.medium:
      return FontWeight.w500;
    case FWT.semiBold:
      return FontWeight.w600;
    case FWT.bold:
      return FontWeight.w700;
    case FWT.black:
      return FontWeight.w800;

    case FWT.extraBold:
      return FontWeight.w900;
  }
}
