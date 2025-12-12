import 'dart:convert';
import 'package:bioburg_lifescience/modules/wishlist/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WishlistController extends GetxController {
  static const String apiBase = "https://bioburglifescience-1.onrender.com";

  var wishlist = <WishlistItem>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchWishlist();
    super.onInit();
  }

  Future<String?> _getToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      print("Token retrieved: ${token != null ? 'Yes' : 'No'}");
      return token;
    } catch (e) {
      print("Error getting token from SharedPreferences: $e");
      return null;
    }
  }

  /// GET WISHLIST ITEMS
  Future<void> fetchWishlist() async {
    try {
      isLoading(true);
      print("Starting to fetch wishlist...");

      final token = await _getToken();
      if (token == null) {
        print("No token found, cannot fetch wishlist");
        return;
      }
      print("Token available, making API call to $apiBase/api/wishlist");

      final response = await http.get(
        Uri.parse("$apiBase/api/wishlist"),
        headers: {"Authorization": "Bearer $token"},
      );

      print("API call completed. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List products = body["products"];

        wishlist.value = products.map((e) => WishlistItem.fromJson(e)).toList();
        print("Wishlist fetched successfully with ${wishlist.length} items");
      } else {
        print("API returned error status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Wishlist fetch error: $e");
    } finally {
      isLoading(false);
    }
  }

  /// REMOVE FROM WISHLIST
  Future<void> removeFromWishlist(String productId) async {
    try {
      final token = await _getToken();
      if (token == null) return;

      await http.delete(
        Uri.parse("$apiBase/api/wishlist/remove/$productId"),
        headers: {"Authorization": "Bearer $token"},
      );

      wishlist.removeWhere((item) => item.id == productId);
      update();
    } catch (e) {
      debugPrint("Remove error: $e");
    }
  }
}
