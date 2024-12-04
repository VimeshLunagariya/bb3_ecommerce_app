import 'package:bb3_ecommerce_app/src/widget/fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';

/// all the validations are stored in this class.
class Validators {
  /// email validation.
  static bool validateEmptyField({required String value}) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validateEmail({required String value}) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return false;
    }
    return true;
  }

  /// password validation is managed in this function.
  static bool validatePassword(BuildContext context, {required String password, required bool showSnack}) {
    if (password.isEmpty) {
      if (showSnack) {
        FancySnackbar.showSnackbar(
          context,
          title: 'Empty Field !',
          message: 'Please fill the password field!',
          snackBarType: FancySnackBarType.error,
          color: SnackBarColors.error4,
          onCloseEvent: () {},
        );
      }
      return false;
    } else if (password.length < 8) {
      if (showSnack) {
        FancySnackbar.showSnackbar(
          context,
          title: 'Invalid Password !',
          message: 'Password must to be atleast 8 charactor long!',
          snackBarType: FancySnackBarType.error,
          color: SnackBarColors.error4,
          onCloseEvent: () {},
        );
      }
      return false;
    } else if (password.length > 15) {
      if (showSnack) {
        FancySnackbar.showSnackbar(
          context,
          title: 'Invalid Password !',
          message: 'Password can be max 15 charector long!',
          snackBarType: FancySnackBarType.error,
          color: SnackBarColors.error4,
          onCloseEvent: () {},
        );
      }

      return false;
    }

    return true;
  }

  /// match password and confirm-password.
  static bool validateConfirmPassword(BuildContext context, {required String password, required String confirmPassword, required bool showSnack}) {
    if (confirmPassword.isEmpty) {
      if (showSnack) {
        FancySnackbar.showSnackbar(
          context,
          title: 'Empty Field !',
          message: 'Please fill the confirm password field!',
          snackBarType: FancySnackBarType.error,
          color: SnackBarColors.error4,
          onCloseEvent: () {},
        );
      }
      return false;
    } else if (password != confirmPassword) {
      if (showSnack) {
        FancySnackbar.showSnackbar(
          context,
          title: 'Invalid Password !',
          message: 'Confirm Password does not match !',
          snackBarType: FancySnackBarType.error,
          color: SnackBarColors.error4,
          onCloseEvent: () {},
        );
      }
      return false;
    }
    return true;
  }

  /// validate phone number.
  static bool validatePhoneNumber({required String phoneNumber}) {
    if (phoneNumber.isEmpty) {
      return false;
    } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,15}$)').hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }

  /// username validation.
  static bool validateUserName(BuildContext context, {required String name, required bool showSnack}) {
    if (name.isEmpty) {
      if (showSnack) {
        FancySnackbar.showSnackbar(
          context,
          title: 'Empty Field !',
          message: 'Please fill the name field !',
          snackBarType: FancySnackBarType.error,
          color: SnackBarColors.error4,
          onCloseEvent: () {},
        );
      }
      return false;
    }
    return true;
  }

  /// image validation.
  static bool validateImage(BuildContext context, {required dynamic image, required showSnack}) {
    if (image == null || image.isEmpty) {
      if (showSnack) {
        FancySnackbar.showSnackbar(
          context,
          title: 'Empty Field !',
          message: 'Please Select Image !',
          snackBarType: FancySnackBarType.error,
          color: SnackBarColors.error4,
          onCloseEvent: () {},
        );
      }
      return false;
    }
    return true;
  }
}
