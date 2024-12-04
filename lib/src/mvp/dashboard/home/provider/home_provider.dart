// ignore_for_file: public_member_api_docs, always_declare_return_types, prefer_final_fields, lines_longer_than_80_chars

import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/api/home_api.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/model/all_brand_model.dart';
import 'package:bb3_ecommerce_app/utilities/asset/asset_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/exception/exception_utilities.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

/// HomeProvider Class: Manages state and API calls for the Home page.
class HomeProvider extends ChangeNotifier {
  // Controller to manage page navigation in the dashboard.
  PageController _dashboardPageController = PageController();
  PageController get dashboardPageController => _dashboardPageController;
  set dashboardPageController(PageController value) {
    _dashboardPageController = value;
    notifyListeners(); // Notify listeners when the controller changes.
  }

  // List of icons and names for the bottom navigation bar.
  List<Map<String, String>> bottomBarIconList = [
    {"img": AssetUtilities.homeIcon, "name": "Home"},
    {"img": AssetUtilities.hotDealIcon, "name": "Hot Deal"},
    {"img": AssetUtilities.wishlistIcon, "name": "Wishlist"},
    {"img": AssetUtilities.cartIcon, "name": "Cart"},
    {"img": AssetUtilities.accountIcon, "name": "Me"},
  ];

  // Current selected page index for the bottom navigation bar.
  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners(); // Notify listeners when the current page changes.
  }

  // List of banner images for the carousel slider.
  List<String> carouselSliderImages = [
    AssetUtilities.banner1,
    AssetUtilities.banner2,
    AssetUtilities.banner1,
    AssetUtilities.banner2,
    AssetUtilities.banner1,
    AssetUtilities.banner2,
  ];

  // Loading state for API calls or other operations.
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners(); // Notify listeners when the loading state changes.
  }

  // Stores the result of the API call for all brands.
  Either<AllBrandModel, Exception> _allBrandModel = Right(NoDataFoundException());
  Either<AllBrandModel, Exception> get allBrandModel => _allBrandModel;
  set allBrandModel(Either<AllBrandModel, Exception> value) {
    _allBrandModel = value;
    notifyListeners(); // Notify listeners when the API result changes.
  }

  /// Calls the All Brand API and updates the state based on the response.
  callAllBrandApi(BuildContext context) async {
    isLoading = true; // Set loading state to true before API call.
    Either<AllBrandModel, Exception> resposne = await allBrandApi(context);
    try {
      if (resposne.isLeft) {
        // If API response is successful.
        if (resposne.left.success ?? false) {
          if (resposne.left.data!.isEmpty) {
            // Handle empty data case.
            isLoading = false;
            allBrandModel = Right(NoDataFoundException());
          } else {
            // Handle valid data case.
            allBrandModel = resposne;
            isLoading = false;
          }
        }
      } else if (resposne.isRight) {
        // Handle exceptions from the API response.
        if (resposne.right is NoInternetException) {
          allBrandModel = Right(NoInternetException());
        } else {
          allBrandModel = Right(NoDataFoundException());
        }
      } else {
        // Fallback for unknown error.
        allBrandModel = Right(NoDataFoundException());
      }
      isLoading = false; // Reset loading state after API call.
    } catch (e) {
      // Catch any unhandled exceptions.
      allBrandModel = Right(NoDataFoundException());
    }
  }
}
