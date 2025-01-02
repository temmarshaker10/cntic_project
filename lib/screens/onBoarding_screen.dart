import 'package:cntic_project/auth/auth_page.dart';
import 'package:cntic_project/components/mytext.dart';
import 'package:cntic_project/screens/screen_1.dart';
import 'package:cntic_project/screens/screen_2.dart';
import 'package:cntic_project/screens/screen_3.dart';
import 'package:cntic_project/screens/screen_4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool inLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                inLastPage = (value == 3);
              });
            },
            controller: _controller,
            children: [Screen1(), Screen2(), Screen3(), Screen4()],
          ),
          Container(
              alignment: Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(3);
                    },
                    child: Mytext(
                        text: "skip",
                        color: Colors.black,
                        fontsize: 15,
                        isBold: true),
                  ),
                  SmoothPageIndicator(controller: _controller, count: 4),
                  inLastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AuthPage();
                            }));
                          },
                          child: Mytext(
                              text: "done",
                              color: Colors.black,
                              fontsize: 15,
                              isBold: true),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut);
                          },
                          child: Mytext(
                              text: "next",
                              color: Colors.black,
                              fontsize: 15,
                              isBold: true),
                        ),
                ],
              ))
        ],
      ),
    );
  }
}
