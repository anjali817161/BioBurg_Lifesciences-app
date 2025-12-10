import 'package:bioburg_lifescience/modules/vendor/auth/register/controller/vendor_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepBasicInfo extends StatelessWidget {
  StepBasicInfo({super.key});

  final controller = Get.find<VendorRegistrationController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("User Information", style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          textField("Full Name", Icons.person, (v) => controller.fullName.value = v),
          textField("Email", Icons.email, (v) => controller.email.value = v),
          textField("Phone", Icons.phone, (v) => controller.phone.value = v),

          textField("Password", Icons.lock, (v) => controller.password.value = v, obscure: true),
          textField("Confirm Password", Icons.lock, (v) => controller.confirmPassword.value = v, obscure: true),

        ],
      ),
    );
  }

  Widget textField(String label, IconData icon, Function(String) onChanged, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        obscureText: obscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
