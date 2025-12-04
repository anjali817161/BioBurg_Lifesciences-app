import 'package:get/get.dart';

class WishlistController extends GetxController {
  // Sample Data – Replace with your API response
  var wishlist = <Map<String, dynamic>>[
    {
      "id": 1,
      "name": "Vitamin C Tablets",
      "price": "₹299",
      "image": "https://bmdublog.com/unitech/public/storage/products/1.jpg"
    },
    {
      "id": 2,
      "name": "Protein Powder",
      "price": "₹999",
      "image": "https://bmdublog.com/unitech/public/storage/products/2.jpg"
    },
  ].obs;

  void removeFromWishlist(int id) {
    wishlist.removeWhere((item) => item["id"] == id);
    update();
  }
}
