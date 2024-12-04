// ignore_for_file: lines_longer_than_80_chars

import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/view/home_screen.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/view/search_screen.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/view/dashboard_screen.dart';
import 'package:bb3_ecommerce_app/src/mvp/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteUtilities {
  static const String root = '/';
  static const String splashScreen = '/splashScreen';
  static const String dashBoardScreen = '/dashBoardScreen';
  static const String homeScreen = '/homeScreen';
  static const String searchScreen = '/searchScreen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name ?? RouteUtilities.root;

    switch (routeName) {
      case RouteUtilities.root:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());

      case RouteUtilities.splashScreen:
        return PageTransition(type: PageTransitionType.fade, child: const SplashScreen());
      case RouteUtilities.dashBoardScreen:
        return PageTransition(type: PageTransitionType.fade, child: const DashBoardScreen());
      case RouteUtilities.homeScreen:
        return PageTransition(type: PageTransitionType.fade, child: const HomeScreen());
      case RouteUtilities.searchScreen:
        return PageTransition(type: PageTransitionType.fade, child: const SearchScreen());
    }
    return null;
  }
}
