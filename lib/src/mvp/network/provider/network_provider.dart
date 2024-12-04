// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

///Class For Network Provider
class NetworkProvider extends ChangeNotifier {
  bool _isInternetConnection = false;

  bool get isInternetConnection => true;

  set isInternetConnection(bool isInternet) {
    _isInternetConnection = isInternet;
    notifyListeners();
  }
}
