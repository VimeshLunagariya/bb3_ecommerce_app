import 'package:bb3_ecommerce_app/src/widget/button/primary_button.dart';
import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Custom dialog for diaplying while logut or exit the app
class CustomDialog {
  ///Show  Dialog
  void showCustomDialog(
    BuildContext context, {
    required String title,
    required String subTitle,
    required String exitBtn,
    required String cancelBtn,
    required VoidCallback exitBtnTap,
    required VoidCallback cancelBtnTap,
    bool? barrierDismissible,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
    TextStyle? exitButtonStyle,
    TextStyle? cancelButtonStyle,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (context) {
        return DeferredPointerHandler(
          child: Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                content: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        Text(
                          title,
                          style: titleStyle ?? FontUtilities.h20(fontColor: VariableUtilities.theme.color444444, fontWeight: FWT.semiBold),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          subTitle, // 'Are you sure want to exit this app?',
                          textAlign: TextAlign.center,
                          style: subTitleStyle ?? FontUtilities.h16(fontColor: VariableUtilities.theme.color7C7C7C, fontWeight: FWT.semiBold),
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                height: 40,
                                onTap: exitBtnTap,
                                title: exitBtn, // 'Exit',
                                textStyle: exitButtonStyle ?? FontUtilities.h15(fontColor: VariableUtilities.theme.primaryColor, fontWeight: FWT.semiBold),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: PrimaryButton(
                                height: 40,
                                onTap: cancelBtnTap,
                                textStyle: cancelButtonStyle ?? FontUtilities.h15(fontColor: VariableUtilities.theme.whiteColor, fontWeight: FWT.semiBold),
                                title: cancelBtn, //'Cancel'
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      top: -25,
                      right: -25,
                      child: DeferPointer(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: VariableUtilities.theme.primaryColor,
                                  ),
                                  child: const Icon(Icons.close_rounded, size: 17, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
