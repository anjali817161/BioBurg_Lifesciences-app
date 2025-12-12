class WishlistItem {
  final String id;
  final String title;
  final String image;
  final double price;
  final double? mrp;
  final int primaryImageIndex;

  WishlistItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.mrp,
    required this.primaryImageIndex,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json["_id"],
      title: json["title"] ?? "",
      price: (json["price"] ?? 0).toDouble(),
      mrp: json["mrp"] != null ? (json["mrp"]).toDouble() : null,
      primaryImageIndex: json["primaryImageIndex"] ?? 0,
      image: json["images"] != null && json["images"].isNotEmpty
          ? json["images"][json["primaryImageIndex"] ?? 0]
          : "",
    );
  }
}
