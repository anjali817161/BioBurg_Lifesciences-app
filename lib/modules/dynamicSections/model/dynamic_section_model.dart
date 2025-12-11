// sections_model.dart
class SectionModel {
  final String id;
  final String title;
  final String subtitle;
  final String key;

  SectionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.key,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      key: json['key'] ?? '',
    );
  }
}

class SectionsResponse {
  final bool success;
  final List<SectionModel> sections;

  SectionsResponse({
    required this.success,
    required this.sections,
  });

  factory SectionsResponse.fromJson(Map<String, dynamic> json) {
    return SectionsResponse(
      success: json['success'] ?? false,
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

// product_model.dart
class ProductModel {
  final String id;
  final String title;
  final String brandName;
  final String manufacturer;
  final String genericName;
  final double mrp;
  final double price;
  final double discountB2C;
  final int stocks;
  final String packagingType;
  final List<String> images;
  final double rating;
  final String shortDescription;
  final String fullDescription;

  ProductModel({
    required this.id,
    required this.title,
    required this.brandName,
    required this.manufacturer,
    required this.genericName,
    required this.mrp,
    required this.price,
    required this.discountB2C,
    required this.stocks,
    required this.packagingType,
    required this.images,
    required this.rating,
    required this.shortDescription,
    required this.fullDescription,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> imageUrls = [];
    if (json['images'] != null) {
      imageUrls = (json['images'] as List)
          .map((img) => img['url'] as String)
          .toList();
    }

    return ProductModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      brandName: json['brandName'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      genericName: json['genericName'] ?? '',
      mrp: (json['mrp'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      discountB2C: (json['discountB2C'] ?? 0).toDouble(),
      stocks: json['stocks'] ?? 0,
      packagingType: json['packagingType'] ?? '',
      images: imageUrls,
      rating: (json['rating'] ?? 0).toDouble(),
      shortDescription: json['shortDescription'] ?? '',
      fullDescription: json['fullDescription'] ?? '',
    );
  }

  double get finalPrice {
    if (price > 0) return price;
    return mrp - (mrp * discountB2C / 100);
  }

  String get discountText {
    if (discountB2C > 0) {
      return '${discountB2C.toStringAsFixed(0)}% OFF';
    }
    return '';
  }
}

class ProductsResponse {
  final bool success;
  final List<ProductModel> products;

  ProductsResponse({
    required this.success,
    required this.products,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      success: json['success'] ?? false,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}