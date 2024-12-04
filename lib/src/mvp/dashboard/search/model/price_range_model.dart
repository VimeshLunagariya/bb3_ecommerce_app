class PriceRange {
  final int? minPrice;
  final int? maxPrice;

  PriceRange({
    this.minPrice,
    this.maxPrice,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        minPrice: json["minPrice"],
        maxPrice: json["maxPrice"],
      );

  Map<String, dynamic> toJson() => {
        "minPrice": minPrice,
        "maxPrice": maxPrice,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceRange && other.minPrice == minPrice && other.maxPrice == maxPrice;
  }

  @override
  int get hashCode {
    return minPrice.hashCode ^ maxPrice.hashCode;
  }
}
