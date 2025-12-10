import 'package:bioburg_lifescience/modules/dynamicSections/model/dynamic_section_model.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class DynamicSectionController extends GetxController {
  var categories = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final url = Uri.parse("https://bioburglifescience-1.onrender.com/api/admin/products/filter");

      final res = await http.get(url
      );  
      // You can adjust endpoint if different

      DynamicSection data = dynamicSectionFromJson(res as String);

      final Set<String> uniqueCats = {};

      for (var p in data.products) {
        p.categories.forEach((key, value) {
          if (value == true) {
            uniqueCats.add(key);
          }
        });
      }

      categories.assignAll(uniqueCats.toList());
    } catch (e) {
      print("Category Load Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
