import 'dart:io';

import 'package:bioburg_lifescience/modules/vendor/auth/register/controller/vendor_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepDocuments extends StatelessWidget {
  StepDocuments({super.key});

  final controller = Get.find<VendorRegistrationController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Upload Documents",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          uploadTile("PAN Card", controller.panImage),
          uploadTile("GST Certificate", controller.gstImage),
          uploadTile("Drug License", controller.drugLicenseImage),
          uploadTile("Cancelled Cheque", controller.chequeImage),
        ],
      ),
    );
  }

  Widget uploadTile(String title, Rx<File?> fileVar) {
    return Obx(() {
      return GestureDetector(
        onTap: () => controller.pickFile(fileVar),
        child: Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.upload_file),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  fileVar.value != null
                      ? fileVar.value!.path.split('/').last
                      : "Upload $title",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
