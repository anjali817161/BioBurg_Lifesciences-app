import 'dart:convert';
import 'package:bioburg_lifescience/modules/home/model/home_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <CategoryModel>[].obs;

  // Replace with your API URL
  final String categoriesUrl = "https://bioburglifescience-1.onrender.com/api/categories/all";

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);

      final response = await http.get(Uri.parse(categoriesUrl));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        categories.value =
            data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetch Categories Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
