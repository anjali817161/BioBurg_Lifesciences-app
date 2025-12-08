import 'dart:convert';
import 'package:bioburg_lifescience/modules/home/model/home_model.dart';
import 'package:bioburg_lifescience/modules/widgets/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <CategoryModel>[].obs;

  final String apiUrl = ApiEndpoints.baseUrl + ApiEndpoints.categoriesMain;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true && data["categories"] != null) {
          categories.value = (data["categories"] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      print("Category Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
