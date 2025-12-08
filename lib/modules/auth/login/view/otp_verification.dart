import 'dart:async';
import 'package:bioburg_lifescience/modules/auth/login/controller/login_controller.dart';
import 'package:bioburg_lifescience/modules/navbar/view/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone;

  const OtpVerificationScreen({
    super.key,
    required this.phone,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _secondsRemaining = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() async {
    final LoginController controller = Get.find<LoginController>();
    final otp = _otpController.text.trim();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    bool success = await controller.verifyOtp(otp);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP Verified Successfully'),
          backgroundColor: Colors.green,
        ),
      );

     
      Get.offAll(() => MainNavigation());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pinTheme = PinTheme(
      width: 55,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = pinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Enter OTP",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "OTP sent to +91 ${widget.phone}",
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),

            const SizedBox(height: 50),

            Center(
              child: Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: pinTheme,
                focusedPinTheme: focusedPinTheme,
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(height: 15),

            Align(
              alignment: Alignment.centerRight,
              child: _secondsRemaining > 0
                  ? Text(
                      "Resend OTP in ${_secondsRemaining}s",
                      style: const TextStyle(color: Colors.grey),
                    )
                  : GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),

            const Spacer(),

            // Verify Button
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
                onPressed:() {
                    Get.to(() => MainNavigation());
                }
                ,
                //  _verifyOtp,
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
