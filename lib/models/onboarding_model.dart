class OnboardingModel {
  final String title;
  final String content;
  final String image;

  OnboardingModel(this.title, this.content, this.image);
}

List<OnboardingModel> contents = [
  OnboardingModel(
    'Welcome to Foundations',
    'Here, we present to you a variety of charities to donate to. These people need your help and are struggling. Why don\'t you be a blessing and save a life today.',
    'assets/images/youssef-naddam-iJ2IG8ckCpA-unsplash.jpg',
  ),
  OnboardingModel(
    'Helping others is what we do best',
    'Here at foundations, we present you the opportunity to touch the lives of many. As the saying goes, it is more blessed to give than to receive.',
    'assets/images/john-onaeko-eoLC-dFIG6s-unsplash(1).jpg',
  ),
  OnboardingModel(
    'Ready to start helping others?',
    'We hope that this bold step you have taken yields positive results. Thank you for choosing foundations!',
    'assets/images/katie-moum-LSrChr55Ggc-unsplash.jpg',
  ),
];
