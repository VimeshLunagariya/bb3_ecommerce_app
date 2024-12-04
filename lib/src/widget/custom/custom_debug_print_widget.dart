// ignore_for_file: public_member_api_docs, unused_local_variable

import 'dart:developer';

import 'package:flutter/foundation.dart';

void customDebugPrintWidget(String text) {
  if (kDebugMode) {
    return log(text);
  } else {
    return debugPrint(text);
  }
}
