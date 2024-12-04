import 'package:flutter/cupertino.dart';

///Global Provider For Chnage State Of Global Variable
class GlobalProvider extends ChangeNotifier {
  bool _isSplashScreen = false;

  ///this variable is use for change the internet widget while user in splash
  ///screen
  ///Variable chnage while user is entered in splash screen
  bool get isSplashScreen => _isSplashScreen;
  set isSplashScreen(bool isSplash) {
    _isSplashScreen = isSplash;

    notifyListeners();
  }

  Widget _internetWidget = const SizedBox();

  ///Change Widget While network Switching
  Widget get internetWidget => _internetWidget;

  set internetWidget(Widget widget) {
    _internetWidget = widget;
    notifyListeners();
  }
}
