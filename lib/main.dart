// // ignore_for_file: lines_longer_than_80_chars, always_declare_return_types, public_member_api_docs
// ignore_for_file: lines_longer_than_80_chars

import 'package:bb3_ecommerce_app/src/mvp/network/view/connectivity_indicator.dart';
import 'package:bb3_ecommerce_app/utilities/provider/provider_binding.dart';
import 'package:bb3_ecommerce_app/utilities/route/route_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  VariableUtilities.preferences = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then(
    (value) {
      return runApp(const ECommerceApp());
    },
  );
}

class ECommerceApp extends StatefulWidget {
  const ECommerceApp({super.key});

  @override
  State<ECommerceApp> createState() => _ECommerceAppState();
}

class _ECommerceAppState extends State<ECommerceApp> with WidgetsBindingObserver {
  late ConnectivityIndicatorWidget connectivityIndicatorWidget;

  @override
  Widget build(BuildContext context) {
    connectivityIndicatorWidget = const ConnectivityIndicatorWidget();
    VariableUtilities.theme = LightTheme();
    return ScreenUtilInit(builder: (_, child) {
      return MultiProvider(
        providers: ProviderBind.providers,
        builder: (BuildContext context, Widget? child) {
          ScreenUtil.init(context);
          return MaterialApp(
            builder: _builder,
            debugShowCheckedModeBanner: false,
            initialRoute: RouteUtilities.root,
            onGenerateRoute: RouteUtilities.onGenerateRoute,
            theme: ThemeData(
              useMaterial3: false,
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color(0xFF254FAD),
                selectionHandleColor: Color(0xFF254FAD),
                selectionColor: Color(0XFFD8407D),
              ),
              colorScheme: const ColorScheme.light(secondary: Color.fromARGB(255, 248, 235, 246)),
            ),
          );
        },
      );
    });
  }

  Widget _builder(BuildContext context, Widget? child) {
    ScreenUtil.init(context);
    return Stack(
      children: <Widget>[
        Stack(
          children: [
            ClipRRect(child: child),
            Positioned(right: 0, bottom: 0, child: connectivityIndicatorWidget),
          ],
        ),
      ],
    );
  }
}
