enum OnboardingIllustration {
  organize,
  deadlines,
  productivity,
}

class OnboardingModel {
  const OnboardingModel({
    required this.title,
    required this.description,
    required this.illustration,
  });

  final String title;
  final String description;
  final OnboardingIllustration illustration;
}