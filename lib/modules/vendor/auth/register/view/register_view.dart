import 'package:bioburg_lifescience/modules/vendor/auth/register/controller/vendor_register_controller.dart';
import 'package:bioburg_lifescience/modules/vendor/auth/register/view/address_bank.dart';
import 'package:bioburg_lifescience/modules/vendor/auth/register/view/basic_info.dart';
import 'package:bioburg_lifescience/modules/vendor/auth/register/view/business_details.dart';
import 'package:bioburg_lifescience/modules/vendor/auth/register/view/documents_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorRegistrationMain extends StatelessWidget {
  VendorRegistrationMain({super.key});

  final controller = Get.put(VendorRegistrationController());

  final pages = [
    StepBasicInfo(),
    StepBusinessDetails(),
    StepAddressBank(),
    StepDocuments(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Registration"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        return Column(
          children: [
            // --------------------------------------------------
            // TOP STEPPER
            // --------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  bool active = controller.currentStep.value >= index;

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor:
                            active ? Colors.blue : Colors.grey.shade300,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: active ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.stepTitles[index],
                        style: TextStyle(
                          color: active ? Colors.blue : Colors.grey,
                          fontSize: 12,
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),

            const Divider(),

            // --------------------------------------------------
            // CURRENT STEP PAGE
            // --------------------------------------------------
            Expanded(child: pages[controller.currentStep.value]),

            // --------------------------------------------------
            // BOTTOM BUTTONS
            // --------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.currentStep.value > 0
                      ? TextButton(
                          onPressed: controller.previousStep,
                          child: const Text("Back"),
                        )
                      : const SizedBox(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(120, 45),
                    ),
                    onPressed: controller.nextStep,
                    child: Text(
                      controller.currentStep.value == 3
                          ? "Submit"
                          : "Next",
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
