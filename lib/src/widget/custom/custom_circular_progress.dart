import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///CutomCircularProgress
class CustomCircularProgress extends StatelessWidget {
  final Color? bgColor;

  ///CustomCircularProgress
  const CustomCircularProgress({super.key, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? VariableUtilities.theme.blackColor.withOpacity(0.6),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: VariableUtilities.theme.primaryColor,
            ),
            SizedBox(height: 5.h),
            Material(
              color: VariableUtilities.theme.transparentColor,
              child: Text(
                'Loading...',
                style: FontUtilities.h15(fontColor: VariableUtilities.theme.whiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
