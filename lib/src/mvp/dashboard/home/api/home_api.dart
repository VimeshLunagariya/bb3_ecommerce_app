// ignore_for_file: avoid_print, prefer_single_quotes, public_member_api_docs

import 'dart:convert';

import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/model/all_brand_model.dart';
import 'package:bb3_ecommerce_app/utilities/api/api.dart';
import 'package:bb3_ecommerce_app/utilities/exception/exception_utilities.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

Future<Either<AllBrandModel, Exception>> allBrandApi(BuildContext context) async {
  Either<dynamic, Exception> data = await API.callAPI(context, url: APIUtilities.allBrandUrl, type: APIType.tGet);
  if (data.isLeft) {
    try {
      return Left(AllBrandModel.fromJson(jsonDecode(jsonEncode(data.left))));
    } catch (e) {
      return Right(DataToModelConversionException());
    }
  } else {
    return Right(data.right);
  }
}
