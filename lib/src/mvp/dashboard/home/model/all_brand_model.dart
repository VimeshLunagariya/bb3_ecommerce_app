// To parse this JSON data, do
//
//     final allBrandModel = allBrandModelFromJson(jsonString);

import 'dart:convert';

AllBrandModel allBrandModelFromJson(String str) => AllBrandModel.fromJson(json.decode(str));

String allBrandModelToJson(AllBrandModel data) => json.encode(data.toJson());

class AllBrandModel {
  final int? statusCode;
  final bool? success;
  final List<Datum>? data;
  final String? path;
  final String? message;
  final Meta? meta;

  AllBrandModel({
    this.statusCode,
    this.success,
    this.data,
    this.path,
    this.message,
    this.meta,
  });

  factory AllBrandModel.fromJson(Map<String, dynamic> json) => AllBrandModel(
        statusCode: json["statusCode"],
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        path: json["path"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "path": path,
        "message": message,
        "meta": meta?.toJson(),
      };
}

class Datum {
  final String? id;
  final String? title;
  final String? description;
  final String? handle;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? status;
  final dynamic metadata;
  final dynamic createdById;
  final Count? count;
  final int? productCount;

  Datum({
    this.id,
    this.title,
    this.description,
    this.handle,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
    this.metadata,
    this.createdById,
    this.count,
    this.productCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        handle: json["handle"],
        image: json["image"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        status: json["status"],
        metadata: json["metadata"],
        createdById: json["createdById"],
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
        productCount: json["productCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "handle": handle,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "status": status,
        "metadata": metadata,
        "createdById": createdById,
        "_count": count?.toJson(),
        "productCount": productCount,
      };
}

class Count {
  final int? products;

  Count({
    this.products,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        products: json["products"],
      );

  Map<String, dynamic> toJson() => {
        "products": products,
      };
}

class Meta {
  final int? total;
  final int? items;
  final int? currentPage;
  final int? perPage;
  final int? lastPage;

  Meta({
    this.total,
    this.items,
    this.currentPage,
    this.perPage,
    this.lastPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        items: json["items"],
        currentPage: json["currentPage"],
        perPage: json["perPage"],
        lastPage: json["lastPage"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "items": items,
        "currentPage": currentPage,
        "perPage": perPage,
        "lastPage": lastPage,
      };
}
