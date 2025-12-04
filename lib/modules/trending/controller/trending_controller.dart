import 'package:get/get.dart';

class TrendingController extends GetxController {
  var trendingProducts = <Map<String, dynamic>>[
    {
      "id": 1,
      "name": "Vitamin C Tablets",
      "price": "₹299",
      "image":
          "assets/images/slider1.webp",
      "isFav": false,
    },
    {
      "id": 2,
      "name": "Pain Relief Gel",
      "price": "₹199",
      "image":
          "assets/images/slider2.webp",
      "isFav": true,
    },
    {
      "id": 3,
      "name": "Protein Powder",
      "price": "₹999",
      "image":
          "assets/images/slider3.webp",
      "isFav": false,
    },
  ].obs;

  void toggleFav(int id) {
    final index = trendingProducts.indexWhere((p) => p["id"] == id);
    trendingProducts[index]["isFav"] = !trendingProducts[index]["isFav"];
    trendingProducts.refresh();
  }

  void addToCart(int id) {
    // Your API logic
    print("Added to cart → $id");
  }
}
