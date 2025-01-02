import 'package:cntic_project/auth/auth_page.dart';
import 'package:cntic_project/firebase_options.dart';
import 'package:cntic_project/pages/home_page.dart';
// ignore: unused_import
import 'package:cntic_project/pages/login_page.dart';
// ignore: unused_import
import 'package:cntic_project/pages/loginorregister.dart';
import 'package:cntic_project/screens/onBoarding_screen.dart';
import 'package:cntic_project/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: OnboardingScreen());
  }
}
