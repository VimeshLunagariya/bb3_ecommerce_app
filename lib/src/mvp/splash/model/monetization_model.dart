// To parse this JSON data, do
//
//     final monetizationModel = monetizationModelFromJson(jsonString);

// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars

import 'dart:convert';

MonetizationModel monetizationModelFromJson(String str) =>
    MonetizationModel.fromJson(json.decode(str));

String monetizationModelToJson(MonetizationModel data) =>
    json.encode(data.toJson());

class MonetizationModel {
  final int? status;
  final String? message;
  final MonetizationData? data;
  final dynamic error;

  MonetizationModel({
    this.status,
    this.message,
    this.data,
    this.error,
  });

  factory MonetizationModel.fromJson(Map<String, dynamic> json) =>
      MonetizationModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] == null
            ? null
            : MonetizationData.fromJson(json['data']),
        error: json['error'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
        'error': error,
      };
}

class MonetizationData {
  final AdNetworks? adNetworks;
  final List<Screen>? screens;
  final String? appTitle;
  final ContactMethods contactMethods;
  final int interstitialCount;
  final bool observeInterCount;
  final int swipeInterCount;
  final int clickInterCount;
  final String? isCategoryUpdated;

  MonetizationData({
    required this.contactMethods,
    required this.interstitialCount,
    required this.observeInterCount,
    required this.swipeInterCount,
    required this.clickInterCount,
    this.isCategoryUpdated,
    this.adNetworks,
    this.screens,
    this.appTitle,
  });

  factory MonetizationData.fromJson(Map<String, dynamic> json) =>
      MonetizationData(
        adNetworks: json['adNetworks'] == null
            ? null
            : AdNetworks.fromJson(json['adNetworks']),
        screens: json['screens'] == null
            ? []
            : List<Screen>.from(
                json['screens']!.map((x) => Screen.fromJson(x))),
        appTitle: json['app_title'],
        contactMethods: ContactMethods.fromJson(json['contact_methods']),
        interstitialCount: json['interstitial_count'],
        observeInterCount: json['observe_inter_count'],
        swipeInterCount: json['swipe_inter_count'],
        clickInterCount: json['click_inter_count'],
        isCategoryUpdated: json['is_category_updated'],
      );

  Map<String, dynamic> toJson() => {
        'adNetworks': adNetworks?.toJson(),
        'screens': screens == null
            ? []
            : List<dynamic>.from(screens!.map((x) => x.toJson())),
        'app_title': appTitle,
        'contact_methods': contactMethods.toJson(),
        'interstitial_count': interstitialCount,
        'observe_inter_count': observeInterCount,
        'swipe_inter_count': swipeInterCount,
        'click_inter_count': clickInterCount,
        'is_category_updated': isCategoryUpdated,
      };
}

class ContactMethods {
  final String ig;
  final String ph;
  final String wp;

  ContactMethods({
    required this.ig,
    required this.ph,
    required this.wp,
  });

  factory ContactMethods.fromJson(Map<String, dynamic> json) => ContactMethods(
        ig: json['ig'],
        ph: json['ph'],
        wp: json['wp'],
      );

  Map<String, dynamic> toJson() => {
        'ig': ig,
        'ph': ph,
        'wp': wp,
      };
}

class AdNetworks {
  final bool? facebook;
  final bool? google;
  final bool? adx;
  final bool? status;

  AdNetworks({
    this.facebook,
    this.google,
    this.adx,
    this.status,
  });

  factory AdNetworks.fromJson(Map<String, dynamic> json) => AdNetworks(
        facebook: json['facebook'],
        google: json['google'],
        adx: json['adx'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'facebook': facebook,
        'google': google,
        'adx': adx,
        'status': status,
      };
}

class Screen {
  final String? name;
  final List<AdType>? adTypes;

  Screen({
    this.name,
    this.adTypes,
  });

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
        name: json['name'],
        adTypes: json['ad_types'] == null
            ? []
            : List<AdType>.from(
                json['ad_types']!.map((x) => AdType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'ad_types': adTypes == null
            ? []
            : List<dynamic>.from(adTypes!.map((x) => x.toJson())),
      };
}

class AdType {
  final String? id;
  final AdUnitId? adUnitId;
  final String? type;

  AdType({
    this.id,
    this.adUnitId,
    this.type,
  });

  factory AdType.fromJson(Map<String, dynamic> json) => AdType(
        id: json['_id'],
        adUnitId: json['ad_unit_id'] == null
            ? null
            : AdUnitId.fromJson(json['ad_unit_id']),
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'ad_unit_id': adUnitId?.toJson(),
        'type': type,
      };
}

class AdUnitId {
  final String? google;
  final String? id;
  final String? facebook;

  AdUnitId({
    this.google,
    this.id,
    this.facebook,
  });

  factory AdUnitId.fromJson(Map<String, dynamic> json) => AdUnitId(
        google: json['google'],
        id: json['_id'],
        facebook: json['facebook'],
      );

  Map<String, dynamic> toJson() => {
        'google': google,
        '_id': id,
        'facebook': facebook,
      };
}
