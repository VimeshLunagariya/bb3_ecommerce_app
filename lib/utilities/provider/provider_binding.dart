// ignore_for_file: lines_longer_than_80_chars

import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/provider/home_provider.dart';
import 'package:bb3_ecommerce_app/src/mvp/network/provider/global_provider.dart';
import 'package:provider/provider.dart';

import '../../src/mvp/dashboard/search/provider/search_provider.dart';

/// This class manage all the provider and return list of provider.
class ProviderBind {
  /// This is the list of providers to manage and attache with application.
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ChangeNotifierProvider<GlobalProvider>(create: (_) => GlobalProvider()),
    ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
  ];
}
