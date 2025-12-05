import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  var product = {
    "name": "Zandu Balm Ayurvedic Pain Relief",
    "short_description": "Effective for headache, body pain & cold.",
    "description":
        "Zandu Balm is an iconic pain relief solution useful for headache, cold, muscle pain and joint pain.",
    "image":
        "https://m.media-amazon.com/images/I/61oQ3lGnndL.jpg",
    "price": 79,
    "mrp": 99,
    "rating": 3.9,
    "sold": 500,
  }.obs;

  /// Related Products (Static)
  var relatedProducts = [
    {
      "name": "Moov Pain Relief Cream",
      "image":
          "https://m.media-amazon.com/images/I/61gNWef39RL.jpg",
      "price": 110,
    },
    {
      "name": "Iodex Rapid Action",
      "image":
          "https://m.media-amazon.com/images/I/71HRHaxDTxL.jpg",
      "price": 95,
    },
    {
      "name": "Volini Spray",
      "image":
          "https://m.media-amazon.com/images/I/61szbmWzx6L.jpg",
      "price": 160,
    },
    {
      "name": "Amrutanjan Strong Balm",
      "image":
          "https://m.media-amazon.com/images/I/61hBTtPlHML.jpg",
      "price": 60,
    },
  ].obs;
}
