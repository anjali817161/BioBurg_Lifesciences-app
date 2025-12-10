class CategoryModel {
  String? id;
  String? title;
  int? offer;
  String? parentCategory;
  String? createdAt;
  String? updatedAt;
  int? v;
  CategoryImage? image;

  CategoryModel({
    this.id,
    this.title,
    this.offer,
    this.parentCategory,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["_id"],
      title: json["title"],
      offer: json["offer"],
      parentCategory: json["parentCategory"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      v: json["__v"],
      image: json["image"] != null
          ? CategoryImage.fromJson(json["image"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "offer": offer,
      "parentCategory": parentCategory,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
      "image": image?.toJson(),
    };
  }
}

class CategoryImage {
  String? url;
  String? publicId;

  CategoryImage({this.url, this.publicId});

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(
      url: json["url"],
      publicId: json["public_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "public_id": publicId,
    };
  }
}
