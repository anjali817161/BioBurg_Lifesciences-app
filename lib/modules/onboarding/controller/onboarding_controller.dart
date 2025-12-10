import 'package:bioburg_lifescience/modules/onboarding/model/onboarding_model.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var pageIndex = 0.obs;

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'assets/images/service1.jpeg',
      title: 'Your Medicines, Delivered Faster',
      subtitle: 'Order authentic medicines and essentials with quick doorstep delivery.',
    ),
    OnboardingModel(
      image: 'assets/images/service2.jpeg',
      title: 'Only Verified & Quality-Checked Medicines',
      subtitle: 'Every product is sourced from certified distributors to ensure safety.',
    ),
    OnboardingModel(
      image: 'assets/images/service3.jpeg',
      title: 'Business To Business (B2B)',
      subtitle: 'Buy medicines and supplies in bulk at wholesale B2B pricing.',
    ),
    OnboardingModel(
      image: 'assets/images/service4.jpeg',
      title: 'Guidance From Healthcare Professionals',
      subtitle: 'Get expert support for your health-related queries anytime.',
    ),
    OnboardingModel(
      image: 'assets/images/service5.jpeg',
      title: 'Pathology & Radiology Tests',
      subtitle: 'Book lab tests easily and get accurate reports delivered to you.',
    ),
    OnboardingModel(
      image: 'assets/images/service6.jpeg',
      title: 'Fast Delivery & Easy Tracking',
      subtitle: 'Track your orders in real time with live delivery status updates.',
    ),
    OnboardingModel(
      image: 'assets/images/service7.jpeg',
      title: 'Hospital and Pharmacy Supplies',
      subtitle: 'Purchase medical equipment and supplies for hospitals and pharmacies.',
    ),
    OnboardingModel(
      image: 'assets/images/service8.jpeg',
      title: 'Patents Pharma Brands Registered With Us',
      subtitle: 'Access products directly from trusted patented pharmaceutical brands.',
    ),
    OnboardingModel(
      image: 'assets/images/service9.jpeg',
      title: 'Health Insurances',
      subtitle: 'Explore health insurance options designed for individuals and families.',
    ),
    OnboardingModel(
      image: 'assets/images/service10.jpeg',
      title: 'Book Lab and Radiology Test',
      subtitle: 'Schedule blood tests, scans, and diagnostics from your home.',
    ),
    OnboardingModel(
      image: 'assets/images/service11.jpeg',
      title: 'Direct Connect to Customer (D2C)',
      subtitle: 'Brands reach customers directly with top-quality health products.',
    ),
    OnboardingModel(
      image: 'assets/images/service12.jpeg',
      title: 'Vendors Sell With Us',
      subtitle: 'Vendors can list, manage, and grow their business with Bioburg.',
    ),
    OnboardingModel(
      image: 'assets/images/service13.jpeg',
      title: 'Dr. Online Consultation',
      subtitle: 'Consult certified doctors online for quick and reliable advice.',
    ),
  ];
}
