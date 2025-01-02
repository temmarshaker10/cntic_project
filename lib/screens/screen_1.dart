import 'package:cntic_project/components/mytext.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Mytext(
              text: "Welcome in CNTIC CLUB",
              color: Colors.white,
              fontsize: 35,
              isBold: true),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Lottie.asset("assets/images/animation_lottie.json"),
          ),
        ],
      ),
    );
  }
}
