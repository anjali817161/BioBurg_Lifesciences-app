import 'package:bioburg_lifescience/modules/vendor/auth/login/controller/vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorLoginPage extends StatelessWidget {
  VendorLoginPage({super.key});

  final VendorLoginController controller = Get.put(VendorLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FE),

      // ---------------- BACK BUTTON -------------------
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blue.shade800,
            size: 22,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ------------------ APP LOGO -----------------------
              Image.asset(
                "assets/images/app_logo.jpeg",
                height: 110,
              ),
              const SizedBox(height: 25),
        
              // ------------------ PAGE TITLE ---------------------
              Text(
                "Vendor Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 10),
        
              Text(
                "Access your partner dashboard",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(height: 40),
        
              // ------------------ FORM ---------------------------
              Container(
                width: 420,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // ---------------- EMAIL ---------------------
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colors.blue.shade700),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) => controller.email.value = value,
                    ),
                    const SizedBox(height: 18),
        
                    // ------------ DRUG LICENSE NUMBER ------------
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Drug License Number",
                        prefixIcon: Icon(Icons.description_outlined,
                            color: Colors.blue.shade700),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) =>
                          controller.drugLicenseNumber.value = value,
                    ),
                    const SizedBox(height: 18),
        
                    // ---------------- PASSWORD -------------------
                    Obx(
                      () => TextField(
                        obscureText: controller.hidePassword.value,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock_outline,
                              color: Colors.blue.shade700),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.hidePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue.shade700,
                            ),
                            onPressed: () {
                              controller.hidePassword.value =
                                  !controller.hidePassword.value;
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onChanged: (value) =>
                            controller.password.value = value,
                      ),
                    ),
        
                    const SizedBox(height: 35),
        
                    // ---------------- LOGIN BUTTON ----------------
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.loginVendor,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 17,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
