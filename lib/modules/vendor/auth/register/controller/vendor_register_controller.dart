import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class VendorRegistrationController extends GetxController {
  var currentStep = 0.obs;

  final stepTitles = [
    "Basic Info",
    "Business Details",
    "Address & Bank",
    "Documents",
  ];

  // ------------------- BASIC INFO ---------------------
  var fullName = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;

  // ------------------- BUSINESS INFO --------------------
  var businessName = "".obs;
  var businessType = "".obs;
  var gstNumber = "".obs;
  var panNumber = "".obs;
  var drugLicense = "".obs;

  // ------------------- ADDRESS & BANK -------------------
  var address = "".obs;
  var city = "".obs;
  var state = "".obs;
  var pincode = "".obs;

  var accHolder = "".obs;
  var accNumber = "".obs;
  var ifscCode = "".obs;
  var branchName = "".obs;

  // ------------------- DOCUMENTS ------------------------
  Rx<File?> panImage = Rx<File?>(null);
  Rx<File?> gstImage = Rx<File?>(null);
  Rx<File?> drugLicenseImage = Rx<File?>(null);
  Rx<File?> chequeImage = Rx<File?>(null);

  final picker = ImagePicker();

  Future pickFile(Rx<File?> variable) async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      variable.value = File(file.path);
    }
  }

  // -------------------------------------------------------
  //     STEP NAVIGATION
  // -------------------------------------------------------
  void nextStep() {
    if (currentStep.value == 3) {
      submitRegistration();
    } else {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  // -------------------------------------------------------
  //     API CALL
  // -------------------------------------------------------
  Future submitRegistration() async {
    var url = Uri.parse(
        "https://bioburglifesciences.in/api/vendor/register");

    var request = http.MultipartRequest("POST", url);

    request.fields.addAll({
      "full_name": fullName.value,
      "email": email.value,
      "phone": phone.value,
      "password": password.value,

      "business_name": businessName.value,
      "business_type": businessType.value,
      "gst_number": gstNumber.value,
      "pan_number": panNumber.value,
      "drug_license": drugLicense.value,

      "address": address.value,
      "city": city.value,
      "state": state.value,
      "pincode": pincode.value,

      "account_holder": accHolder.value,
      "account_number": accNumber.value,
      "ifsc_code": ifscCode.value,
      "branch_name": branchName.value,
    });

    if (panImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          "pan_image", panImage.value!.path));
    }

    if (gstImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          "gst_image", gstImage.value!.path));
    }

    var response = await request.send();
    var resBody = await response.stream.bytesToString();

    print("API RESPONSE: $resBody");

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Vendor Registered Successfully");
    } else {
      Get.snackbar("Error", "Something Went Wrong");
    }
  }
}
