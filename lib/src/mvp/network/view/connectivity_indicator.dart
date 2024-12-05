// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:bb3_ecommerce_app/src/mvp/network/provider/global_provider.dart';
import 'package:bb3_ecommerce_app/utilities/asset/asset_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

///Connectivity Indicator
class ConnectivityIndicatorWidget extends StatefulWidget {
  ///Connectivity Indicator

  const ConnectivityIndicatorWidget({super.key});

  @override
  ConnectivityIndicatorWidgetState createState() =>
      ConnectivityIndicatorWidgetState();
}

class ConnectivityIndicatorWidgetState
    extends State<ConnectivityIndicatorWidget> {
  Color color = Colors.white;
  double width = 20;
  double pos = 16;
  IconData iconData = Icons.wifi;

  @override
  void initState() {
    super.initState();
    var globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ConnectivityService((result, isOnline) async {
        // NetworkManager().handleConnectionManager(result, isOnline);
        Timer(const Duration(seconds: 2), () {
          // hideStatus();
        });

        if (result.contains(ConnectivityResult.none)) {
          color = Colors.red;
          globalProvider.internetWidget = Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                AssetUtilities.noInternetPngImage,
                height: VariableUtilities.screenSize.height,
                width: VariableUtilities.screenSize.width,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetUtilities.logoPng, height: 100, width: 100)
                ],
              )
            ],
          );
          iconData = Icons.wifi_off;
        } else if (result.contains(ConnectivityResult.wifi)) {
          color = Colors.green;
          iconData = Icons.wifi;
          globalProvider.internetWidget = const SizedBox();

          if (!isOnline) {
            color = Colors.orange;
            iconData = Icons.no_cell_outlined;
            globalProvider.internetWidget = Image.asset(
              AssetUtilities.noInternetPngImage,
              height: VariableUtilities.screenSize.height,
              width: VariableUtilities.screenSize.width,
            );
          }
        } else if (result.contains(ConnectivityResult.mobile)) {
          iconData = Icons.import_export_outlined;
          color = Colors.blue;
          globalProvider.internetWidget = const SizedBox();
          if (!isOnline) {
            iconData = Icons.no_cell_outlined;
            color = Colors.orange;
            globalProvider.internetWidget = Image.asset(
              AssetUtilities.noInternetPngImage,
              height: VariableUtilities.screenSize.height,
              width: VariableUtilities.screenSize.width,
            );
          }
        }
      }).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (_, GlobalProvider globalProvider, __) {
      return SafeArea(
        bottom: false,
        child: Container(
          child:
              // VariableUtilities.isSplashScreen == false

              globalProvider.isSplashScreen == false
                  ? AnimatedContainer(
                      decoration: BoxDecoration(
                          // color: color,
                          boxShadow: [
                            BoxShadow(
                              color: VariableUtilities.theme.whiteColor,
                            )
                          ]),
                      duration: const Duration(milliseconds: 400),
                      // height: VariableUtilities.screenSize.height,
                      // width: VariableUtilities.screenSize.width,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            globalProvider.internetWidget,
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
        ),
      );
    });
  }
}

/// Uses the [Connectivity] plugin to listen to connectivity changes.
///
/// Should be initialized to set the initial connectivity state.
///
typedef ConnectivityCallback = Function(
    List<ConnectivityResult> state, bool isConnected);

///
class ConnectivityService {
  ///
  ConnectivityCallback? callback;

  ///
  static ConnectivityService? instance;

  ///
  List<ConnectivityResult> result = [ConnectivityResult.none];

  ///
  bool isConnected = false;

  ///
  ConnectivityService._();

  ///
  factory ConnectivityService(ConnectivityCallback callback) {
    if (instance == null) {
      instance = ConnectivityService._();
      instance!.callback = callback;
      return instance!;
    } else {
      instance!.callback = callback;
      return instance!;
    }
  }

  ///

  Connectivity connectivity = Connectivity();

  ///
  void initialize() async {
    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    _checkStatus(result);

    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(List<ConnectivityResult> cResult) async {
    result = cResult;
    isConnected = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    } on SocketException catch (e) {
      isConnected = false;
    }
    instance?.callback!(result, isConnected);
  }
}
