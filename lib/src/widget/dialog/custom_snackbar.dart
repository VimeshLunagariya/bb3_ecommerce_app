// ignore_for_file: public_member_api_docs

import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';

/// This is the enum for custom snackbar types.
enum SnackType {
  /// success.
  success,

  /// error.
  error,

  /// pending.
  pending,

  /// waiting.
  waiting,
}

/// get Color based on the snackbar type.
Color getSnackColor(SnackType type) {
  switch (type) {
    case SnackType.success:
      return VariableUtilities.theme.successColor;
    case SnackType.error:
      return VariableUtilities.theme.errorColor;
    case SnackType.pending:
      return VariableUtilities.theme.pendingColor;
    case SnackType.waiting:
      return VariableUtilities.theme.waitingColor;
  }
}

/// custom snackbar.
void showFancySnackbar(
  BuildContext context, {
  required String title,
  required String message,
  SnackType type = SnackType.success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: FontUtilities.h18(
                fontColor: VariableUtilities.theme.whiteColor,
                fontWeight: FWT.semiBold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Text(
                message,
                style: FontUtilities.h14(
                  fontColor: VariableUtilities.theme.whiteColor,
                  fontWeight: FWT.semiBold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: getSnackColor(type),
    ),
  );
}
