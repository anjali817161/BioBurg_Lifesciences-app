import 'package:bioburg_lifescience/modules/vendor/auth/register/controller/vendor_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepBusinessDetails extends StatelessWidget {
  StepBusinessDetails({super.key});

  final controller = Get.find<VendorRegistrationController>();

  final businessTypes = [
    "Pharma Distributor",
    "Medical Store",
    "Franchise Partner",
    "Manufacturer",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Business Details", style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          textField("Business Name", Icons.store, (v) => controller.businessName.value = v),

          DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Business Type",
            ),
            items: businessTypes
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => controller.businessType.value = value!,
          ),

          const SizedBox(height: 12),

          textField("GST Number", Icons.qr_code, (v) => controller.gstNumber.value = v),
          textField("PAN Number", Icons.credit_card, (v) => controller.panNumber.value = v),
          textField("Drug License No.", Icons.description, (v) => controller.drugLicense.value = v),
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
