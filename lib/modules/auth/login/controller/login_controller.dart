import 'dart:convert';
import 'package:bioburg_lifescience/modules/auth/login/view/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isLoading = false.obs;
  var phone = "".obs;

  // 🔵 SEND OTP API
  Future<void> sendOtp(String phoneNumber) async {
    phone.value = phoneNumber;
    isLoading.value = true;

    try {
      final url = Uri.parse("https://yourapi.com/send-mobile-otp"); // 🔗 UPDATE THIS

      final response = await http.post(
        url,
        body: {
          "phone": phoneNumber,
        },
      );

      final data = jsonDecode(response.body);
      isLoading.value = false;

      if (response.statusCode == 200 && data["success"] == true) {
        // OTP sent ✔
        Get.snackbar(
          "Success",
          data["message"] ?? "OTP sent successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.to(() => OtpVerificationScreen(phone: phoneNumber));

      } else {
        // API error ❌
        Get.snackbar(
          "Error",
          data["message"] ?? "Something went wrong",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to send OTP: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // 🔵 VERIFY OTP API
  Future<bool> verifyOtp(String otp) async {
    try {
      final url = Uri.parse("https://yourapi.com/verify-mobile-otp"); // 🔗 UPDATE THIS

      final response = await http.post(
        url,
        body: {
          "phone": phone.value,
          "otp": otp,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        return true; // Verified ✔
      } else {
        Get.snackbar(
          "Invalid OTP",
          data["message"] ?? "Please enter a valid OTP",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "OTP verification failed: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
  }
}
