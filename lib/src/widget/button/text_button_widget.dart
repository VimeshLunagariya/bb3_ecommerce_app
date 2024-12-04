import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';

///Text button
class TextButtonWidget extends StatelessWidget {
  ///Constructor Text button

  const TextButtonWidget({
    required this.onTap,
    required this.title,
    this.textStyle,
    this.overlayColor,
    super.key,
  });

  ///call back for button
  final VoidCallback onTap;

  ///Overlay color
  final Color? overlayColor;

  ///Button title
  final String title;

  ///Textstyle
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: ButtonStyle(overlayColor: WidgetStateProperty.all(overlayColor ?? VariableUtilities.theme.primaryColor.withOpacity(0.1))),
        child: Text(
          title,
          style: textStyle ?? FontUtilities.h14(fontColor: VariableUtilities.theme.primaryColor),
        ));
  }
}
