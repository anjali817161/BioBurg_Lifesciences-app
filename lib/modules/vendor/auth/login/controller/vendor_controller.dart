import 'dart:convert';
import 'package:bioburg_lifescience/modules/widgets/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorLoginController extends GetxController {

  var email = "".obs;
  var drugLicenseNumber = "".obs;
  var password = "".obs;

  var isLoading = false.obs;
  var hidePassword = true.obs;

  Future<void> loginVendor() async {
    try {
      isLoading.value = true;

      final url = Uri.parse("${ApiEndpoints.baseUrl2}${ApiEndpoints.vendorLogin}");

      final body = {
        "email": email.value.trim(),
        "drugLicenseNumber": drugLicenseNumber.value.trim(),
        "password": password.value.trim(),
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Store token
        Get.snackbar("Success", "Login Successful");

        // Save token locally
        // Using GetStorage or SharedPreferences
        // Example:
        // box.write("vendorToken", data["token"]);

        // Navigate to Vendor Dashboard
        Get.offAllNamed("/vendorDashboard");
      } else {
        Get.snackbar("Login Error", data["message"] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
