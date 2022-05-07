import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/models/onboarding_model.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _controller;

  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: contents.length,
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (_, i) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      contents[i].image,
                    ),
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black,
                    ],
                    stops: const [
                      0.0,
                      1,
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contents[i].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      contents[i].content,
                      style: const TextStyle(
                        color: kLightTextColor,
                        fontSize: kDefaultFontSize,
                        height: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DotsIndicator(
                            dotsCount: 3,
                            position: currentIndex.toDouble(),
                            decorator: DotsDecorator(
                              size: const Size.square(9.0),
                              color: Colors.grey,
                              spacing: const EdgeInsets.all(3),
                              sizes: const [
                                Size(12, 12),
                                Size(12, 12),
                                Size(12, 12),
                              ],
                              activeSize: const Size(50.0, 9.0),
                              activeColor: Colors.white,
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (currentIndex == contents.length - 1) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamedAndRemoveUntil(
                                        '/login', (route) => false);
                              }
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.bounceIn,
                              );
                            },
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    child: Text('Next'),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
