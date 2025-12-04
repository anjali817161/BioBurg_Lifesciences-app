import 'package:get/get.dart';

class ProductListController extends GetxController {
  // Selected subcategory name (send from previous page)
  String subcategoryName = "";

  // STATIC PRODUCT LIST for now
  var products = <ProductModel>[
    ProductModel(
      name: "Vitamin C Chewable Tablets - Orange Flavour",
      price: 25.5,
      oldPrice: 30.0,
      image:
          "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/l/i/lim0028.jpg",
      rating: 4.5,
    ),
    ProductModel(
      name: "Omega 3 Fish Oil Softgels",
      price: 299,
      oldPrice: 349,
      image:
          "https://cdn-icons-png.flaticon.com/512/1827/1827504.png",
      rating: 4.4,
    ),
    ProductModel(
      name: "Vitamin D3 60000 IU Capsules",
      price: 150,
      oldPrice: 190,
      image:
          "https://cdn-icons-png.flaticon.com/512/3004/3004618.png",
      rating: 4.6,
    ),
  ].obs;

  void setSubcategory(String name) {
    subcategoryName = name;
    update();
  }

  void toggleFavorite(int index) {
    products[index].isFav = !products[index].isFav;
    update();
  }
}

class ProductModel {
  String name;
  double price;
  double oldPrice;
  String image;
  double rating;
  bool isFav;

  ProductModel({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.rating,
    this.isFav = false,
  });
}
