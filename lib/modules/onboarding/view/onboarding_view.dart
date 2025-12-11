import 'package:bioburg_lifescience/modules/auth/login/view/login_view.dart';
import 'package:bioburg_lifescience/modules/auth/login/view/number_login.dart';
import 'package:bioburg_lifescience/modules/home/view/home_view.dart';
import 'package:bioburg_lifescience/modules/navbar/view/bottom_navbar.dart';
import 'package:bioburg_lifescience/modules/onboarding/controller/onboarding_controller.dart';
import 'package:bioburg_lifescience/modules/usertype/usertype_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final OnboardingController controller = Get.put(OnboardingController());
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _autoSlide();
  }

  void _autoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      int nextPage = (controller.pageIndex.value + 1) % controller.onboardingPages.length;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      controller.pageIndex.value = nextPage;
      _autoSlide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // PAGE VIEW
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) => controller.pageIndex.value = index,
                  itemCount: controller.onboardingPages.length,
                  itemBuilder: (context, index) {
                    final page = controller.onboardingPages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1),
                          // IMAGE CONTAINER WITH CONSISTENT SIZE AND BLEND
                          Obx(
                            () => AnimatedOpacity(
                              opacity: controller.pageIndex.value == index ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.45,
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.blue.withOpacity(0.1),
                                      Colors.transparent,
                                    ],
                                    radius: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Image.asset(
                                  page.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                          // TITLE
                          Obx(
                            () => AnimatedOpacity(
                              opacity: controller.pageIndex.value == index ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 700),
                              child: Text(
                                page.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // SUBTITLE
                          Obx(
                            () => AnimatedOpacity(
                              opacity: controller.pageIndex.value == index ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 900),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  page.subtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // DOT INDICATORS
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardingPages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: controller.pageIndex.value == index ? 32 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: controller.pageIndex.value == index
                            ? Colors.blue.shade700
                            : Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade800],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade300.withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}