// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
part of 'api.dart';

class APIUtilities {
  static const String _baseUrl = 'https://bb3-api.ashwinsrivastava.com/';

  ///GET PRODUCT BY SEARCH
  static const String searchCardsUrl = '${_baseUrl}store/product-search';

  ///GET ALL BRAND
  static const String allBrandUrl = '${_baseUrl}store/brand';
}
