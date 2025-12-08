class CategoryModel {
  final String id;
  final String title;
  final String imageUrl;
  final int offer;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.offer,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      imageUrl: json["image"]?["url"] ?? "",
      offer: json["offer"] ?? 0,
    );
  }
}



class CategoryDrawerModel {
  final String title;
  final List<String> subcategories;

  CategoryDrawerModel({
    required this.title,
    required this.subcategories,
  });
}
