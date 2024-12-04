library provider_app_apis;

import 'dart:convert';

import 'package:bb3_ecommerce_app/src/widget/custom/custom_debug_print_widget.dart';
import 'package:bb3_ecommerce_app/src/widget/fancy_snackbar/snackbar_widget.dart';
import 'package:bb3_ecommerce_app/utilities/exception/exception_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/local_cache_key.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'api_manager.dart';
part 'api_utilities.dart';
