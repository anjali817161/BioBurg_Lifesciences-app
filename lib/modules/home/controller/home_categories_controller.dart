import 'dart:convert';
import 'package:bioburg_lifescience/modules/home/model/home_categories_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../widgets/api_endpoints.dart';

class CategoryDetailsController extends GetxController {
  // ----------------------------
  // STATES
  // ----------------------------
  var isLoading = false.obs;

  var subCategories = <CategoryModel>[].obs;
  var products = <ProductModel>[].obs;
  var wishlist = <String>[].obs;

  var categoryName = "".obs;
  var mainCategoryName = "".obs;

  var brands = <String>[].obs;
  var selectedBrands = <String>[].obs;

  var maxPrice = 1000.0.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPriceValue = 1000.0.obs;

  var sortBy = "".obs;

  String token = "";

  @override
  void onInit() {
    // token = GetStorage().read("token") ?? "";
    super.onInit();
  }

  // ----------------------------------------------------------
  // LOAD MAIN CATEGORY (SUBCATEGORIES + PRODUCTS)
  // ----------------------------------------------------------
  Future<void> loadMainCategory(String id) async {
    try {
      isLoading(true);
      categoryName(id);

      // LOAD subcategories
      final subRes = await http.get(Uri.parse(
          "${ApiEndpoints.baseUrl}categories?parent=$id"));

      print("DEBUG: Subcategories API URL: ${ApiEndpoints.baseUrl}categories?parent=$id");
      print("DEBUG: Subcategories Response Status: ${subRes.statusCode}");
      print("DEBUG: Subcategories Response Body: ${subRes.body}");

      if (subRes.statusCode == 200) {
        final data = jsonDecode(subRes.body);
        subCategories.value = (data["categories"] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        print("DEBUG: Subcategories loaded: ${subCategories.length}");
      } else {
        print("DEBUG: Failed to load subcategories");
      }

      // LOAD products
      await _loadProducts(main: id);
    } finally {
      isLoading(false);
    }
  }

  // ----------------------------------------------------------
  // LOAD SUBCATEGORY (GET PARENT + PRODUCTS)
  // ----------------------------------------------------------
  Future<void> loadSubCategory(String id) async {
    try {
      isLoading(true);

      final allRes = await http.get(
          Uri.parse("${ApiEndpoints.baseUrl}categories/all"));

      if (allRes.statusCode == 200) {
        final data = jsonDecode(allRes.body)["categories"];

        final list = (data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        final current = list.firstWhere((e) => e.id == id);

        categoryName(current.title);

        final parent = list.firstWhereOrNull(
            (e) => e.id == current.parentCategory);

        mainCategoryName(parent?.title ?? "");
      }

      // LOAD products
      await _loadProducts(category: id);
    } finally {
      isLoading(false);
    }
  }

  // ----------------------------------------------------------
  // PRODUCTS LOADER
  // ----------------------------------------------------------
  Future<void> _loadProducts({String? main, String? category}) async {
    String url =
        "${ApiEndpoints.baseUrl}admin/products/filter?"

        "${main != null ? "main=$main" : ""}"
        "${category != null ? "category=$category" : ""}";

    print("DEBUG: Products API URL: $url");
    final res = await http.get(Uri.parse(url));
    print("DEBUG: Products Response Status: ${res.statusCode}");
    print("DEBUG: Products Response Body: ${res.body}");

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);

      final list = (json["products"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      products.value = list;
      print("DEBUG: Products loaded: ${products.length}");

      // brand list
      brands.value = list.map((e) => e.brand).toSet().toList();

      // price range
      if (list.isNotEmpty) {
        maxPrice(list.map((e) => e.price).reduce((a, b) => a > b ? a : b));
        maxPriceValue(maxPrice.value);
      }
    } else {
      print("DEBUG: Failed to load products");
    }
  }

  // ----------------------------------------------------------
  // WISHLIST LOAD
  // ----------------------------------------------------------
  Future<void> loadWishlist() async {
    if (token.isEmpty) return;

    final res = await http.get(
      Uri.parse("${ApiEndpoints.baseUrl}wishlist"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      wishlist.value = List<String>.from(
        data["products"].map((e) => e["_id"]),
      );
    }
  }

  // ----------------------------------------------------------
  // ADD / REMOVE
  // ----------------------------------------------------------
  Future<void> toggleWishlist(String id) async {
    if (token.isEmpty) {
      Get.snackbar("Login Required", "Please login first");
      return;
    }

    if (wishlist.contains(id)) {
      await http.delete(
        Uri.parse("${ApiEndpoints.baseUrl}wishlist/remove/$id"),
        headers: {"Authorization": "Bearer $token"},
      );
      wishlist.remove(id);
    } else {
      await http.post(
        Uri.parse("${ApiEndpoints.baseUrl}wishlist/add/$id"),
        headers: {"Authorization": "Bearer $token"},
      );
      wishlist.add(id);
    }
  }

  // ----------------------------------------------------------
  // FILTER + SORT LOGIC
  // ----------------------------------------------------------
  List<ProductModel> filteredProducts() {
    List<ProductModel> list = [...products];

    // BRAND FILTER
    if (selectedBrands.isNotEmpty) {
      list = list.where((p) => selectedBrands.contains(p.brand)).toList();
    }

    // PRICE FILTER
    list = list
        .where((p) =>
            p.price >= minPrice.value && p.price <= maxPriceValue.value)
        .toList();

    // SORT
    if (sortBy.value == "low-high") {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy.value == "high-low") {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortBy.value == "discount") {
      list.sort((a, b) =>
          (b.discountPercent ?? 0).compareTo(a.discountPercent ?? 0));
    } else if (sortBy.value == "newest") {
      list.sort((a, b) =>
          DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
    }

    return list;
  }
}
