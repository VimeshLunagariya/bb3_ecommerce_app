// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs, always_declare_return_types, library_private_types_in_public_api

import 'dart:async';

import 'package:bb3_ecommerce_app/src/mvp/network/provider/global_provider.dart';
import 'package:bb3_ecommerce_app/utilities/asset/asset_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/route/route_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/local_cache_key.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      /// Initiate SpalshScreen For Identifire for the Route
      var globalProvider = Provider.of<GlobalProvider>(context, listen: false);
      globalProvider.isSplashScreen = true;
    });

    // Timer to navigate to HomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      VariableUtilities.preferences.setBool(LocalCacheKey.applicationLoginState, true);

      /// Navigate to DashBoard Screen
      Navigator.pushReplacementNamed(context, RouteUtilities.dashBoardScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    VariableUtilities.screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(AssetUtilities.logoPng),
              width: VariableUtilities.screenSize.width * 0.60,
            ),
          ],
        ),
      ),
    );
  }
}
