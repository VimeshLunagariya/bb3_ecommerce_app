// ignore_for_file: public_member_api_docs

part of 'theme.dart';

/// all the colores used in the application are managed using this theme_base.
/// if you want to use the additional colors then you can add in this class.
///
abstract class ThemeBase {
  /// Constructor of the theme_base to required all the colors.
  ThemeBase({
    required this.successColor,
    required this.errorColor,
    required this.pendingColor,
    required this.waitingColor,
    required this.backgroundColor,
    required this.transparentColor,
    required this.color444444,
    required this.whiteColor,
    required this.blackColor,
    required this.primaryColor,
    required this.color7C7C7C,
    required this.colorE06159,
    required this.color4FA332,
    required this.colorE94444,
    required this.color38D900,

    // required this.color236480,
    // required this.color2D6E77,
    // required this.color313984,
    // required this.color66440C,
    // required this.color8E3A3A,
    // required this.color9c9b9b,
    // required this.color9F9F9F,
    // required this.colorF1F1F1,
    // required this.color4B4E4D,
    // required this.colorE9EDF7,
    // required this.colorD9D9D9,
  });

  final Color successColor;
  final Color errorColor;
  final Color pendingColor;
  final Color waitingColor;
  final Color whiteColor;
  final Color primaryColor;
  final Color backgroundColor;
  final Color transparentColor;
  final Color color444444;
  final Color color7C7C7C;
  final Color blackColor;
  final Color colorE06159;
  final Color color4FA332;
  final Color color38D900;
  final Color colorE94444;
  // final Color colorBB5CA8;
  // final Color color236480;
  // final Color color66440C;
  // final Color color8E3A3A;
  // final Color color313984;
  // final Color color2D6E77;
  // final Color color9c9b9b;
  // final Color color9F9F9F;
  // final Color colorF1F1F1;
  // final Color color4B4E4D;
  // final Color colorE9EDF7;
  // final Color colorD9D9D9;
}
