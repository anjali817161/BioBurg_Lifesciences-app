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

      int nextPage =
          (controller.pageIndex.value + 1) % controller.onboardingPages.length;

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
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Image.asset(
                            page.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
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
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.pageIndex.value == index ? 12 : 8,
                    height: controller.pageIndex.value == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: controller.pageIndex.value == index
                          ? Colors.blue
                          : Colors.blue.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(() => LoginScreen());
                  // Get.offAll(() => MainNavigation());
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
