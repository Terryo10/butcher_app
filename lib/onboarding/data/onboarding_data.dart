import '../../constants/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'Welcome to vintage meats',
      description:
          'Experience the finest cuts, responsibly sourced and expertly prepared. Freshness and quality are at the heart of every order.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Exclusive Offers & Savings',
      description:
          'Get amazing deals on premium meats. Explore discounts and special bundles curated just for you.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Fast & Reliable Delivery',
      description:
          'Your meat, delivered to your doorstep within desired time. From our butcher to your table—fresh, every time.',
    ),
  ];
}
