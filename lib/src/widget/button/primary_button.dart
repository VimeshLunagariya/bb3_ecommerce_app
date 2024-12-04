// ignore_for_file: public_member_api_docs

import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Primary button
class PrimaryButton extends StatelessWidget {
  ///Constructor Primary button

  const PrimaryButton({
    required this.onTap,
    required this.title,
    this.height,
    this.width,
    this.centerWidget,
    this.color,
    this.titleColor,
    this.borderColor,
    this.textStyle,
    this.decoration,
    super.key,
  });

  ///call back for button
  final VoidCallback onTap;

  ///Button height
  final double? height;

  ///Button width
  final double? width;

  ///Button color
  final Color? color;

  ///Button title color
  final Color? titleColor;

  ///Button Border color
  final Color? borderColor;

  ///Button title
  final String title;

  ///Text style
  final TextStyle? textStyle;

  final Widget? centerWidget;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height ?? 45.h,
      minWidth: width ?? 222.w,
      color: decoration != null
          ? decoration!.color == true
              ? decoration!.color
              : VariableUtilities.theme.whiteColor
          : color ?? VariableUtilities.theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor ?? VariableUtilities.theme.primaryColor, width: 1.5),
      ),
      child: centerWidget ??
          Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle ?? FontUtilities.h13(fontColor: titleColor ?? VariableUtilities.theme.whiteColor, fontWeight: FWT.semiBold),
          ),
    );
  }
}
