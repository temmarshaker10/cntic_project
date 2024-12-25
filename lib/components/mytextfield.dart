import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardtype;
  final String hintText;
  bool obsecuretext;
  Mytextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecuretext,
      required this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        keyboardType: keyboardtype,
        controller: controller,
        obscureText: obsecuretext,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
            fillColor: Colors.grey.shade200,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Colors.grey.shade500),
            )),
      ),
    );
  }
}
