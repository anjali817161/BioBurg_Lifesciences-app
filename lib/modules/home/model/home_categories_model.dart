class CategoryModel {
  final String id;
  final String title;
  final String? parentCategory;

  CategoryModel({
    required this.id,
    required this.title,
    this.parentCategory,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["_id"],
      title: json["title"] ?? "",
      parentCategory: json["parentCategory"],
    );
  }
}


class ProductModel {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double? mrp;
  final double? discountPercent;
  final String category;
  final String createdAt;
  final List<dynamic> images;
  final int primaryImageIndex;

  ProductModel({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.mrp,
    this.discountPercent,
    required this.category,
    required this.createdAt,
    required this.images,
    required this.primaryImageIndex,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"],
      title: json["title"] ?? "",
      brand: json["brand"] ?? "",
      price: (json["price"] ?? 0).toDouble(),
      mrp: json["mrp"]?.toDouble(),
      discountPercent: json["discountPercent"]?.toDouble(),
      category: json["category"] ?? "",
      createdAt: json["createdAt"] ?? "",
      images: json["images"] ?? [],
      primaryImageIndex: json["primaryImageIndex"] ?? 0,
    );
  }
}
