import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/mytext.dart';
import '../auth/auth_page.dart';
import '../components/mytext.dart';
import '../components/theme_switch.dart';
import '../screens/screen_2.dart';
import '../screens/screen_3.dart';
import '../screens/screen_4.dart';
import '../screens/screen_1.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool inLastPage = false;

  // Update when page changes
  void onPageChanged(int page) {
    setState(() {
      inLastPage = (page == 3); // The last page index is 3
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for onboarding screens
          PageView(
            onPageChanged: onPageChanged,
            controller: _controller,
            children: [
              Screen1(),
              Screen2(),
              Screen3(),
              Screen4(),
            ],
          ),
          // Bottom navigation and page indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip button
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(3); // Jump to last page
                  },
                  child: Mytext(
                    text: "Skip",
                    color: Colors.black,
                    fontsize: 15,
                    isBold: true,
                  ),
                ),
                // Page indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: WormEffect(),
                ),
                // "Next" or "Done" button
                inLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return AuthPage();
                            }),
                          );
                        },
                        child: Mytext(
                          text: "Done",
                          color: Colors.black,
                          fontsize: 15,
                          isBold: true,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Mytext(
                          text: "Next",
                          color: Colors.black,
                          fontsize: 15,
                          isBold: true,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
