import 'package:cntic_project/components/mytext.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Mytext(
                text:
                    "Connect with programmers and creatives who share your passion.",
                color: Colors.white,
                fontsize: 35,
                isBold: true),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Lottie.asset("assets/images/animation_lottie_3.json"),
          ),
        ],
      ),
    );
  }
}
