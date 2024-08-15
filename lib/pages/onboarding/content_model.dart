class OnboardingContent {
  String image;
  String title;

  OnboardingContent({required this.image, required this.title});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Sevimli ovqatga buyurtma bering',
      image: 'assets/img/onboarding - 1.png'),
  OnboardingContent(
      title: 'Tezkor yetkazib berish', image: 'assets/img/onboarding - 2.png'),
  OnboardingContent(
      title: 'Yoqimli ishtaxa', image: 'assets/img/onboarding - 3.png')
];
