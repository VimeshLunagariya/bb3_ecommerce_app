// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

SearchProductModel searchProductModelFromJson(String str) => SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) => json.encode(data.toJson());

class SearchProductModel {
  final int? statusCode;
  final bool? success;
  final Data? data;
  final String? path;
  final String? message;
  Meta? meta;

  SearchProductModel({
    this.statusCode,
    this.success,
    this.data,
    this.path,
    this.message,
    this.meta,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) => SearchProductModel(
        statusCode: json["statusCode"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        path: json["path"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "data": data?.toJson(),
        "path": path,
        "message": message,
        "meta": meta?.toJson(),
      };
}

class Data {
  List<Product>? products;
  List<BrandElement>? brands;
  List<Attribute>? attributes;
  final Map<String, int>? ratingsCounts;

  Data({
    this.products,
    this.brands,
    this.attributes,
    this.ratingsCounts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        brands: json["brands"] == null ? [] : List<BrandElement>.from(json["brands"]!.map((x) => BrandElement.fromJson(x))),
        attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
        ratingsCounts: Map.from(json["ratingsCounts"]!).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "ratingsCounts": Map.from(ratingsCounts!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Attribute {
  final String? title;
  final String? code;
  final List<Value>? values;

  Attribute({
    this.title,
    this.code,
    this.values,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        title: json["title"],
        code: json["code"],
        values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
        "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attribute && other.title == title && other.code == code && _listEquals(other.values, values);
  }

  @override
  int get hashCode => Object.hash(title, code, values);

  bool _listEquals(List<Value>? list1, List<Value>? list2) {
    if (list1 == null || list2 == null) return list1 == list2;
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}

class Value {
  final String? value;
  final int? productCount;

  Value({
    this.value,
    this.productCount,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        value: json["value"],
        productCount: json["productCount"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "productCount": productCount,
      };

  // Manually overriding the '==' operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Value && other.value == value && other.productCount == productCount;
  }

  // Manually overriding the 'hashCode' getter
  @override
  int get hashCode {
    return value.hashCode ^ productCount.hashCode;
  }
}

class BrandElement {
  final String? id;
  final String? handle;
  final String? name;
  final int? productCount;

  BrandElement({
    this.id,
    this.handle,
    this.name,
    this.productCount,
  });

  factory BrandElement.fromJson(Map<String, dynamic> json) => BrandElement(
        id: json["id"],
        handle: json["handle"],
        name: json["name"],
        productCount: json["productCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "handle": handle,
        "name": name,
        "productCount": productCount,
      };

  // Manually overriding the '==' operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandElement && other.id == id && other.handle == handle && other.name == name && other.productCount == productCount;
  }

  // Manually overriding the 'hashCode' getter
  @override
  int get hashCode {
    return id.hashCode ^ handle.hashCode ^ name.hashCode ^ productCount.hashCode;
  }
}

class Product {
  final String? id;
  final String? title;
  final dynamic subtitle;
  final String? description;
  final String? handle;
  final dynamic weight;
  final dynamic height;
  final dynamic width;
  final dynamic length;
  final dynamic hsCode;
  final dynamic originCountry;
  final dynamic midCode;
  final dynamic material;
  final Metadata? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String>? tags;
  final String? brandId;
  final String? status;
  final dynamic createdById;
  final String? productCategoryId;
  final String? thumbnail;
  final String? productAttributeGroupId;
  final String? metaTitle;
  final String? metaDescription;
  final ProductBrand? brand;
  final ProductCategory? productCategory;
  final List<dynamic>? productCollections;
  final List<ProductValuesForAttribute>? productValuesForAttribute;
  final List<Variant>? variants;
  final List<ProductImage>? productImages;
  final List<Review>? reviews;
  final Count? count;
  final double? averageRating;
  final int? priceStart;
  final dynamic priceEnd;

  Product({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.handle,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.hsCode,
    this.originCountry,
    this.midCode,
    this.material,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.brandId,
    this.status,
    this.createdById,
    this.productCategoryId,
    this.thumbnail,
    this.productAttributeGroupId,
    this.metaTitle,
    this.metaDescription,
    this.brand,
    this.productCategory,
    this.productCollections,
    this.productValuesForAttribute,
    this.variants,
    this.productImages,
    this.reviews,
    this.count,
    this.averageRating,
    this.priceStart,
    this.priceEnd,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        handle: json["handle"],
        weight: json["weight"],
        height: json["height"],
        width: json["width"],
        length: json["length"],
        hsCode: json["hs_code"],
        originCountry: json["origin_country"],
        midCode: json["mid_code"],
        material: json["material"],
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        brandId: json["brandId"],
        status: json["status"],
        createdById: json["createdById"],
        productCategoryId: json["productCategoryId"],
        thumbnail: json["thumbnail"],
        productAttributeGroupId: json["productAttributeGroupId"],
        metaTitle: json["metaTitle"],
        metaDescription: json["metaDescription"],
        brand: json["brand"] == null ? null : ProductBrand.fromJson(json["brand"]),
        productCategory: json["productCategory"] == null ? null : ProductCategory.fromJson(json["productCategory"]),
        productCollections: json["productCollections"] == null ? [] : List<dynamic>.from(json["productCollections"]!.map((x) => x)),
        productValuesForAttribute:
            json["productValuesForAttribute"] == null ? [] : List<ProductValuesForAttribute>.from(json["productValuesForAttribute"]!.map((x) => ProductValuesForAttribute.fromJson(x))),
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        productImages: json["productImages"] == null ? [] : List<ProductImage>.from(json["productImages"]!.map((x) => ProductImage.fromJson(x))),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
        averageRating: json["averageRating"]?.toDouble(),
        priceStart: json["priceStart"],
        priceEnd: json["priceEnd"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "handle": handle,
        "weight": weight,
        "height": height,
        "width": width,
        "length": length,
        "hs_code": hsCode,
        "origin_country": originCountry,
        "mid_code": midCode,
        "material": material,
        "metadata": metadata?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "brandId": brandId,
        "status": status,
        "createdById": createdById,
        "productCategoryId": productCategoryId,
        "thumbnail": thumbnail,
        "productAttributeGroupId": productAttributeGroupId,
        "metaTitle": metaTitle,
        "metaDescription": metaDescription,
        "brand": brand?.toJson(),
        "productCategory": productCategory?.toJson(),
        "productCollections": productCollections == null ? [] : List<dynamic>.from(productCollections!.map((x) => x)),
        "productValuesForAttribute": productValuesForAttribute == null ? [] : List<dynamic>.from(productValuesForAttribute!.map((x) => x.toJson())),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "productImages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x.toJson())),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "_count": count?.toJson(),
        "averageRating": averageRating,
        "priceStart": priceStart,
        "priceEnd": priceEnd,
      };
}

class ProductBrand {
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

  ProductBrand({
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
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
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
      };
}

class Count {
  final int? lineItems;

  Count({
    this.lineItems,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        lineItems: json["lineItems"],
      );

  Map<String, dynamic> toJson() => {
        "lineItems": lineItems,
      };
}

class Metadata {
  final String? excerpt;

  Metadata({
    this.excerpt,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        excerpt: json["excerpt"],
      );

  Map<String, dynamic> toJson() => {
        "excerpt": excerpt,
      };
}

class ProductCategory {
  final String? id;
  final String? name;
  final String? description;
  final String? handle;
  final dynamic image;
  final dynamic parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? rank;
  final String? fullPath;
  final String? fullPathHandle;
  final dynamic metadata;
  final String? createdById;
  final dynamic parent;

  ProductCategory({
    this.id,
    this.name,
    this.description,
    this.handle,
    this.image,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.rank,
    this.fullPath,
    this.fullPathHandle,
    this.metadata,
    this.createdById,
    this.parent,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        handle: json["handle"],
        image: json["image"],
        parentId: json["parentId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        rank: json["rank"],
        fullPath: json["fullPath"],
        fullPathHandle: json["fullPathHandle"],
        metadata: json["metadata"],
        createdById: json["createdById"],
        parent: json["parent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "handle": handle,
        "image": image,
        "parentId": parentId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "rank": rank,
        "fullPath": fullPath,
        "fullPathHandle": fullPathHandle,
        "metadata": metadata,
        "createdById": createdById,
        "parent": parent,
      };
}

class ProductImage {
  final String? id;
  final String? productId;
  final String? image;
  final int? order;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic createdById;
  final dynamic productVariantId;

  ProductImage({
    this.id,
    this.productId,
    this.image,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.createdById,
    this.productVariantId,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        productId: json["productId"],
        image: json["image"],
        order: json["order"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdById: json["createdById"],
        productVariantId: json["productVariantId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "image": image,
        "order": order,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdById": createdById,
        "productVariantId": productVariantId,
      };
}

class ProductValuesForAttribute {
  final String? id;
  final String? productId;
  final String? productAttributeId;
  final String? productAttributeValueId;
  final dynamic value;
  final ProductAttribute? productAttribute;
  final ProductAttributeValue? productAttributeValue;

  ProductValuesForAttribute({
    this.id,
    this.productId,
    this.productAttributeId,
    this.productAttributeValueId,
    this.value,
    this.productAttribute,
    this.productAttributeValue,
  });

  factory ProductValuesForAttribute.fromJson(Map<String, dynamic> json) => ProductValuesForAttribute(
        id: json["id"],
        productId: json["productId"],
        productAttributeId: json["productAttributeId"],
        productAttributeValueId: json["productAttributeValueId"],
        value: json["value"],
        productAttribute: json["productAttribute"] == null ? null : ProductAttribute.fromJson(json["productAttribute"]),
        productAttributeValue: json["productAttributeValue"] == null ? null : ProductAttributeValue.fromJson(json["productAttributeValue"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productAttributeId": productAttributeId,
        "productAttributeValueId": productAttributeValueId,
        "value": value,
        "productAttribute": productAttribute?.toJson(),
        "productAttributeValue": productAttributeValue?.toJson(),
      };
}

class ProductAttribute {
  final String? id;
  final String? title;
  final String? type;
  final String? code;
  final bool? isRequired;
  final bool? isUnique;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic metadata;
  final String? createdById;

  ProductAttribute({
    this.id,
    this.title,
    this.type,
    this.code,
    this.isRequired,
    this.isUnique,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
    this.createdById,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        code: json["code"],
        isRequired: json["isRequired"],
        isUnique: json["isUnique"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        metadata: json["metadata"],
        createdById: json["createdById"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "code": code,
        "isRequired": isRequired,
        "isUnique": isUnique,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "metadata": metadata,
        "createdById": createdById,
      };
}

class ProductAttributeValue {
  final String? id;
  final String? productAttributeId;
  final String? value;
  final int? position;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic metadata;

  ProductAttributeValue({
    this.id,
    this.productAttributeId,
    this.value,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory ProductAttributeValue.fromJson(Map<String, dynamic> json) => ProductAttributeValue(
        id: json["id"],
        productAttributeId: json["productAttributeId"],
        value: json["value"],
        position: json["position"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        metadata: json["metadata"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productAttributeId": productAttributeId,
        "value": value,
        "position": position,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "metadata": metadata,
      };
}

class Review {
  final int? rating;

  Review({
    this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
      };
}

class Variant {
  final String? id;
  final String? productId;
  final String? title;
  final String? sku;
  final dynamic barcode;
  final dynamic ean;
  final dynamic upc;
  final int? inventoryQuantity;
  final bool? allowBackOrder;
  final bool? manageInventory;
  final dynamic hsCode;
  final dynamic originCountry;
  final dynamic midCode;
  final dynamic material;
  final dynamic weight;
  final dynamic height;
  final dynamic length;
  final dynamic width;
  final int? variantRank;
  final int? price;
  final int? specialPrice;
  final dynamic specialPriceStartDate;
  final dynamic specialPriceEndDate;
  final int? inventory;
  final dynamic metadata;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final DateTime? updatedAt;
  final String? thumbnail;
  final dynamic createdById;
  final List<dynamic>? prices;
  final int? originalPrice;
  final int? currentPrice;
  final SalePrices? salePrices;

  Variant({
    this.id,
    this.productId,
    this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.inventoryQuantity,
    this.allowBackOrder,
    this.manageInventory,
    this.hsCode,
    this.originCountry,
    this.midCode,
    this.material,
    this.weight,
    this.height,
    this.length,
    this.width,
    this.variantRank,
    this.price,
    this.specialPrice,
    this.specialPriceStartDate,
    this.specialPriceEndDate,
    this.inventory,
    this.metadata,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.thumbnail,
    this.createdById,
    this.prices,
    this.originalPrice,
    this.currentPrice,
    this.salePrices,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        productId: json["productId"],
        title: json["title"],
        sku: json["sku"],
        barcode: json["barcode"],
        ean: json["ean"],
        upc: json["upc"],
        inventoryQuantity: json["inventoryQuantity"],
        allowBackOrder: json["allowBackOrder"],
        manageInventory: json["manageInventory"],
        hsCode: json["hsCode"],
        originCountry: json["originCountry"],
        midCode: json["midCode"],
        material: json["material"],
        weight: json["weight"],
        height: json["height"],
        length: json["length"],
        width: json["width"],
        variantRank: json["variantRank"],
        price: json["price"],
        specialPrice: json["specialPrice"],
        specialPriceStartDate: json["specialPriceStartDate"],
        specialPriceEndDate: json["specialPriceEndDate"],
        inventory: json["inventory"],
        metadata: json["metadata"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        thumbnail: json["thumbnail"],
        createdById: json["createdById"],
        prices: json["prices"] == null ? [] : List<dynamic>.from(json["prices"]!.map((x) => x)),
        originalPrice: json["originalPrice"],
        currentPrice: json["currentPrice"],
        salePrices: json["salePrices"] == null ? null : SalePrices.fromJson(json["salePrices"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "title": title,
        "sku": sku,
        "barcode": barcode,
        "ean": ean,
        "upc": upc,
        "inventoryQuantity": inventoryQuantity,
        "allowBackOrder": allowBackOrder,
        "manageInventory": manageInventory,
        "hsCode": hsCode,
        "originCountry": originCountry,
        "midCode": midCode,
        "material": material,
        "weight": weight,
        "height": height,
        "length": length,
        "width": width,
        "variantRank": variantRank,
        "price": price,
        "specialPrice": specialPrice,
        "specialPriceStartDate": specialPriceStartDate,
        "specialPriceEndDate": specialPriceEndDate,
        "inventory": inventory,
        "metadata": metadata,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "thumbnail": thumbnail,
        "createdById": createdById,
        "prices": prices == null ? [] : List<dynamic>.from(prices!.map((x) => x)),
        "originalPrice": originalPrice,
        "currentPrice": currentPrice,
        "salePrices": salePrices?.toJson(),
      };
}

class SalePrices {
  SalePrices();

  factory SalePrices.fromJson(Map<String, dynamic> json) => SalePrices();

  Map<String, dynamic> toJson() => {};
}

class Meta {
  final int? total;
  final int? items;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  Meta({
    this.total,
    this.items,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        items: json["items"],
        perPage: json["perPage"],
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "items": items,
        "perPage": perPage,
        "currentPage": currentPage,
        "lastPage": lastPage,
      };
}
