import 'package:bioburg_lifescience/modules/vendor/auth/register/controller/vendor_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepAddressBank extends StatelessWidget {
  StepAddressBank({super.key});

  final controller = Get.find<VendorRegistrationController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Address Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),

          textField("Address", Icons.home, (v) => controller.address.value = v),
          textField("City", Icons.location_city, (v) => controller.city.value = v),
          textField("State", Icons.map, (v) => controller.state.value = v),
          textField("Pincode", Icons.pin, (v) => controller.pincode.value = v),

          const SizedBox(height: 20),

          const Text("Bank Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),

          textField("Account Holder", Icons.person, (v) => controller.accHolder.value = v),
          textField("Account Number", Icons.account_balance, (v) => controller.accNumber.value = v),
          textField("IFSC Code", Icons.code, (v) => controller.ifscCode.value = v),
          textField("Branch Name", Icons.apartment, (v) => controller.branchName.value = v),
        ],
      ),
    );
  }

  Widget textField(String label, IconData icon, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
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
