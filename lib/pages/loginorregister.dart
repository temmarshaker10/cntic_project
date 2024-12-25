import 'package:cntic_project/pages/login_page.dart';
import 'package:cntic_project/pages/register_page.dart';
import 'package:flutter/material.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  bool showogin = true;

  void toggelPage() {
    setState(() {
      showogin = !showogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showogin) {
      return LoginPage(onTap: toggelPage);
    } else {
      return RegisterPage(onTap: toggelPage);
    }
  }
}
