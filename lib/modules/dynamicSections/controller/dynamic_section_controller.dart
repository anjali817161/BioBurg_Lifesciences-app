// sections_controller.dart
import 'dart:ffi';

import 'package:bioburg_lifescience/modules/dynamicSections/model/dynamic_section_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Import your models
// import 'package:your_app/models/sections_model.dart';
// import 'package:your_app/models/product_model.dart';

class SectionsController extends GetxController {
  // Observable lists
  var sections = <SectionModel>[].obs;
  var sectionProducts = <String, List<ProductModel>>{}.obs;
  
  // Loading states
  var isLoadingSections = true.obs;
  var isLoadingProducts = <String, bool>{}.obs;
  
  // Error states
  var hasError = false.obs;
  var errorMessage = ''.obs;
 bool isFav = false;

  final String sectionsUrl = 'https://bioburglifescience-1.onrender.com/api/sections';
  final String productsUrl = 'https://bioburglifescience-1.onrender.com/api/admin/products/filter';

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  // Load all data
  Future<void> loadAllData() async {
    await fetchSections();
    if (sections.isNotEmpty) {
      await fetchAllSectionProducts();
    }
  }

  // Fetch sections from API
  Future<void> fetchSections() async {
    try {
      isLoadingSections.value = true;
      hasError.value = false;

      final response = await http.get(Uri.parse(sectionsUrl));

      print("statuscode-----${response.statusCode}");
      print("body=-----${response.body}");
      print(sectionsUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final sectionsResponse = SectionsResponse.fromJson(data);
        sections.value = sectionsResponse.sections;
      } else {
        throw Exception('Failed to load sections');
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load sections: ${e.toString()}';
      print('Error fetching sections: $e');
    } finally {
      isLoadingSections.value = false;
    }
  }

  // Fetch products for all sections
  Future<void> fetchAllSectionProducts() async {
    for (var section in sections) {
      await fetchProductsForSection(section.key);
    }
  }

  // Fetch products for a specific section
  Future<void> fetchProductsForSection(String sectionKey) async {
    try {
      isLoadingProducts[sectionKey] = true;
      update(); // Notify listeners
      
      final response = await http.get(
        Uri.parse(productsUrl),
        headers: {'Content-Type': 'application/json'},
      
      );

       print("statuscode-----${response.statusCode}");
      print("body=-----${response.body}");
      print(productsUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final productsResponse = ProductsResponse.fromJson(data);
        sectionProducts[sectionKey] = productsResponse.products;
      } else {
        sectionProducts[sectionKey] = [];
      }
    } catch (e) {
      print('Error fetching products for $sectionKey: $e');
      sectionProducts[sectionKey] = [];
    } finally {
      isLoadingProducts[sectionKey] = false;
      update(); // Notify listeners
    }
  }

    // Get trending products (for separate page)
  List<ProductModel> getTrendingProducts() {
    return sectionProducts['isTrending'] ?? [];
  }

  // Get all non-trending sections
  List<SectionModel> getNonTrendingSections() {
    return sections.where((section) => section.key != 'isTrending').toList();
  }

  // Refresh all data
  Future<void> refreshData() async {
    sections.clear();
    sectionProducts.clear();
    isLoadingProducts.clear();
    await loadAllData();
  }

  // Get products for a section
  List<ProductModel> getProductsForSection(String sectionKey) {
    return sectionProducts[sectionKey] ?? [];
  }

  // Check if section is loading
  bool isSectionLoading(String sectionKey) {
    return isLoadingProducts[sectionKey] ?? false;
  }
}
