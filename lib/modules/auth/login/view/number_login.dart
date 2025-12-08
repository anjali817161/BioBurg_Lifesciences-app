import 'package:bioburg_lifescience/modules/auth/login/controller/login_controller.dart';
import 'package:bioburg_lifescience/modules/auth/login/view/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final LoginController loginController = Get.put(LoginController());

  final TextEditingController _phoneController = TextEditingController();
  String completePhoneNumber = '';
  String numberOnly = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Mobile Number",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "We'll send an OTP to verify",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 25),

              IntlPhoneField(
                controller: _phoneController,
                dropdownTextStyle: const TextStyle(color: Colors.blue),
                style: const TextStyle(color: Colors.blue, fontSize: 17),
                cursorColor: Colors.blue,
                dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                decoration: InputDecoration(
                  labelText: 'Enter mobile number',
                  labelStyle: const TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  completePhoneNumber = phone.completeNumber;
                  numberOnly = phone.number;
                },
                validator: (phone) {
                  if (phone == null || phone.number.isEmpty) {
                    return 'Please enter your mobile number';
                  } else if (phone.number.length < 10) {
                    return 'Enter valid 10-digit number';
                  }
                  return null;
                },
              ),

              const Spacer(),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   loginController.sendOtp(numberOnly);
                    // }
                    Get.to(() => OtpVerificationScreen(phone: numberOnly));
                  },
                  child: Obx(() => loginController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Get OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_right_alt, color: Colors.white),
                          ],
                        )),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
