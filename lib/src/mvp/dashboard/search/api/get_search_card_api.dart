// ignore_for_file: avoid_print, prefer_single_quotes, public_member_api_docs

import 'dart:convert';

import 'package:bb3_ecommerce_app/src/mvp/dashboard/search/model/search_languages_card_model.dart';
import 'package:bb3_ecommerce_app/utilities/api/api.dart';
import 'package:bb3_ecommerce_app/utilities/exception/exception_utilities.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

Future<Either<SearchProductModel, Exception>> searchCardApi(BuildContext context, {required Map<String, dynamic> params}) async {
  Map<String, dynamic> parameters = params;

  Either<dynamic, Exception> data = await API.callAPI(context, url: APIUtilities.searchCardsUrl, type: APIType.tGet, parameters: parameters);
  if (data.isLeft) {
    try {
      return Left(SearchProductModel.fromJson(jsonDecode(jsonEncode(data.left))));
    } catch (e) {
      return Right(DataToModelConversionException());
    }
  } else {
    return Right(data.right);
  }
}
