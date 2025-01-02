import 'package:cntic_project/components/mytext.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(
                    text:
                        "Your gateway to learning everything related to programming",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Lottie.asset("assets/images/animation_lottie_2.json"),
          ),
        ],
      ),
    );
  }
}
