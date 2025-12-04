import 'package:bioburg_lifescience/modules/onboarding/model/onboarding_model.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var pageIndex = 0.obs;

  final List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    image: 'assets/images/doctor1.png',
    title: 'Your Medicines, Delivered Faster',
    subtitle: 'Order genuine healthcare products anytime with just a tap.',
  ),
  OnboardingModel(
    image: 'assets/images/doctor2.png',
    title: 'Only Verified & Quality-Checked Medicines',
    subtitle: 'We source directly from certified distributors to ensure authenticity.',
  ),
  OnboardingModel(
    image: 'assets/images/doctor3.png',
    title: 'Save More on Every Order',
    subtitle: 'Get exclusive discounts, offers, and economical medicine packages.',
  ),
  OnboardingModel(
    image: 'assets/images/doctor4.png',
    title: 'Guidance From Healthcare Professionals',
    subtitle: 'Get assistance when you need it—safe, reliable, and expert-backed.',
  ),
  OnboardingModel(
    image: 'assets/images/doctor5.png',
    title: 'Fast Delivery & Easy Tracking',
    subtitle: 'Track your order in real time with our smooth delivery system.',
  ),
];

}
