import 'package:cntic_project/components/mytext.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Mytext(
              text:
                  "Get ready for the challenge and be part of the world of the future!",
              color: Colors.white,
              fontsize: 35,
              isBold: true),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Lottie.asset("assets/images/animation_lottie_4.json"),
          ),
        ],
      ),
    );
  }
}
