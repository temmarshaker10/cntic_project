// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Mytext extends StatelessWidget {
  final String text;
  final Color color;
  final double fontsize;
  bool isBold;
  Mytext(
      {super.key,
      required this.text,
      required this.color,
      required this.fontsize,
      required this.isBold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontsize,
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
