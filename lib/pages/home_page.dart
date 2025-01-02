import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cntic_project/components/mytext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
        title: Mytext(
            text: "Welcome", color: Colors.white, fontsize: 30, isBold: true),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Mytext(
                text: "Welcome:" + user.email!,
                color: Colors.black,
                fontsize: 20,
                isBold: true),
          ),
        ],
      ),
    );
  }
}
