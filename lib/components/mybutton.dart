import 'package:cntic_project/components/mytext.dart';
import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  Mybutton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13), color: Colors.black),
          child: Center(
            child: Mytext(
                text: text, color: Colors.white, fontsize: 25.0, isBold: true),
          ),
        ),
      ),
    );
  }
}
