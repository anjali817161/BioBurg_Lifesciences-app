import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  // LOADING STATE (In case of API)
  var isLoading = false.obs;

  // Selected values
  var selectedSubCategory = 0.obs;
  var currentPage = 1.obs;

  // Cart functionality
  var cartMap = {}.obs;

  // Per page items (for View More pagination)
  final int itemsPerPage = 6;

  // Selected category name from previous screen
  String selectedCategory = "";

  // 🌐 STATIC CATEGORY + PRODUCT DATA (Replace later with API)
  Map<String, dynamic> allCategories = {
    "Homeopathy": {
      "subcategories": [
        "Cough & Cold",
        "Digestive Health",
        "Skin Care",
        "Pain Relief",
        "Immunity Boosters"
      ],
      "products": {
        "Cough & Cold": [
          {
            "title": "Arnica Montana 30C",
            "price": "₹85",
            "old_price": "₹100",
            "rating": "4.6",
            "rating_count": "5432",
            "offer": "15% off",
            "image":
                "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/h/o/hom001.jpg"
          },
          {
            "title": "Bryonia 30C",
            "price": "₹90",
            "old_price": "₹120",
            "rating": "4.5",
            "rating_count": "4231",
            "offer": "10% off",
            "image":
                "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/h/o/hom001.jpg"
          },
          {
            "title": "Bryonia 30C",
            "price": "₹90",
            "old_price": "₹120",
            "rating": "4.5",
            "rating_count": "4231",
            "offer": "10% off",
            "image":
                "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/h/o/hom001.jpg"
          },
          {
            "title": "Bryonia 30C",
            "price": "₹90",
            "old_price": "₹120",
            "rating": "4.5",
            "rating_count": "4231",
            "offer": "10% off",
            "image":
                "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/h/o/hom001.jpg"
          },
        ],
       
        "Digestive Health": [],
        "Skin Care": [],
        "Pain Relief": [],
        "Immunity Boosters": [],
      }
    },

    // --- UNANI ---
    "Unani": {
      "subcategories": [
      
        "Herbal Supplements",
        "Digestive Aids",
        "Skin & Hair",
        "Joint Health",
        "General Wellness"
      ],
      "products": {
        "Herbal Supplements": [
          {
            "title": "Unani Herbal Tea",
            "price": "₹120",
            "old_price": "₹150",
            "rating": "4.4",
            "rating_count": "3210",
            "offer": "20% off",
            "image":
                "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/u/n/una001.jpg"
          },
        ],
        "Digestive Aids": [],
        "Skin & Hair": [],
        "Joint Health": [],
        "General Wellness": [],
      }
    },

    // --- NUTRITION + VITAMINS ---
    "Vitamins": {
      "subcategories": [
        "Top Picks",
        "Omega & Fish Oil",
        "Vitamin D",
        "Vitamin B",
        "Vitamin C",
        "Vitamin A"
      ],
      "products": {
        "Top Picks": [
          {
            "title": "Limcee Vitamin C",
            "price": "₹23.4",
            "old_price": "₹24.7",
            "rating": "4.5",
            "rating_count": "17537",
            "offer": "5% off",
            "image":
                "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/l/i/lim0028.jpg"
          },
        ],
        "Omega & Fish Oil": [
          {
            "title": "Fish Oil 1000mg Capsules",
            "price": "₹289",
            "old_price": "₹349",
            "rating": "4.3",
            "rating_count": "6421",
            "offer": "17% off",
            "image":
                "https://newassets.apollo247.com/pub/media/catalog/product/cache/resized/160x160/f/i/fis001.jpg"
          },
        ],
        "Vitamin D": [],
        "Vitamin B": [],
        "Vitamin C": [],
        "Vitamin A": [],
      }
    },
  };

  // ===========================================================
  // 🔹 LOAD CATEGORY WHEN USER NAVIGATES FROM CATEGORY PAGE
  // ===========================================================
  void loadCategory(String categoryName) {
    selectedCategory = categoryName;
    selectedSubCategory.value = 0; // default first subcategory
    currentPage.value = 1;
    update();
  }

  // ===========================================================
  // 🔹 GET SUBCATEGORIES
  // ===========================================================
  List<String> getSubCategories() {
    if (selectedCategory.isEmpty) return [];
    return List<String>.from(allCategories[selectedCategory]["subcategories"]);
  }

  // ===========================================================
  // 🔹 GET PRODUCTS for selected subcategory
  // ===========================================================
  List<dynamic> getProducts() {
    if (selectedCategory.isEmpty) return [];
    String subCat = getSubCategories()[selectedSubCategory.value];
    return List<dynamic>.from(allCategories[selectedCategory]["products"][subCat]);
  }

  // ===========================================================
  // 🔹 PAGINATED PRODUCTS (VIEW MORE LOGIC)
  // ===========================================================
  List<dynamic> paginatedProducts() {
    final fullList = getProducts();
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;

    if (start >= fullList.length) return [];
    if (end > fullList.length) end = fullList.length;

    return fullList.sublist(start, end);
  }

  // ===========================================================
  // 🔹 CHANGE SUBCATEGORY
  // ===========================================================
  void changeSubCategory(int index) {
    selectedSubCategory.value = index;
    currentPage.value = 1; // reset pagination
    update();
  }

  // ===========================================================
  // 🔹 LOAD MORE PRODUCTS
  // ===========================================================
  void loadMore() {
    currentPage.value++;
    update();
  }

  // ===========================================================
  // 🔹 CART METHODS
  // ===========================================================
  void addToCart(dynamic product) {
    String key = product["title"];
    if (cartMap.containsKey(key)) {
      cartMap[key] = cartMap[key] + 1;
    } else {
      cartMap[key] = 1;
    }
    update();
  }

  void increaseQty(dynamic product) {
    String key = product["title"];
    if (cartMap.containsKey(key)) {
      cartMap[key] = cartMap[key] + 1;
    }
    update();
  }

  void decreaseQty(dynamic product) {
    String key = product["title"];
    if (cartMap.containsKey(key) && cartMap[key] > 0) {
      cartMap[key] = cartMap[key] - 1;
      if (cartMap[key] == 0) {
        cartMap.remove(key);
      }
    }
    update();
  }
}
