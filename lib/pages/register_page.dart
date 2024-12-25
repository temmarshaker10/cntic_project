import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cntic_project/auth/auth_services.dart';
import 'package:cntic_project/components/mybutton.dart';
import 'package:cntic_project/components/mytext.dart';
import 'package:cntic_project/components/mytextfield.dart';
import 'package:cntic_project/components/squareTaile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  // Function to handle user registration
  Future<void> signUp() async {
    // Check if passwords match
    if (password.text != confirmPassword.text) {
      _showErrorDialog('Passwords do not match.');
      return;
    }

    // Check if the email is valid
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(email.text)) {
      _showErrorDialog('Invalid email format.');
      return;
    }

    // Show loading circle while attempting to register
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Attempt to create a user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      addUser(email.text, username.text);

      // Dismiss the loading dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration Successful'),
      ));
    } on FirebaseAuthException catch (e) {
      // Dismiss the loading dialog
      Navigator.of(context).pop();

      // Handle specific FirebaseAuth errors
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'weak-password':
          errorMessage =
              'The password is too weak. Please choose a stronger password.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }

      // Show dialog with the specific error message
      _showErrorDialog(errorMessage);
    }
  }

  Future addUser(String email, String username) async {
    // Create a new user with the given email and username
    await FirebaseFirestore.instance
        .collection("users")
        .add({'email': email, 'username': username});
  }

  // Function to show an error dialog with the provided message
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                // Logo
                Icon(Icons.lock, size: 100),
                SizedBox(height: 20),

                // Welcome Text
                Mytext(
                    text: "Hi There",
                    color: Colors.grey.shade500,
                    fontsize: 30,
                    isBold: false),
                SizedBox(height: 20),

                // Username textfield
                Mytextfield(
                    keyboardtype: TextInputType.name,
                    controller: username,
                    hintText: "UserName",
                    obsecuretext: false),
                SizedBox(height: 10),

                // Email textfield
                Mytextfield(
                    keyboardtype: TextInputType.emailAddress,
                    controller: email,
                    hintText: "Email",
                    obsecuretext: false),
                SizedBox(height: 10),

                // Password textfield
                Mytextfield(
                    keyboardtype: TextInputType.visiblePassword,
                    controller: password,
                    hintText: "Password",
                    obsecuretext: true),
                SizedBox(height: 10),

                // Confirm Password textfield
                Mytextfield(
                    keyboardtype: TextInputType.visiblePassword,
                    controller: confirmPassword,
                    hintText: "Confirm Password",
                    obsecuretext: true),
                SizedBox(height: 10),
                SizedBox(height: 20),

                // Sign Up button
                Mybutton(
                  onTap: signUp,
                  text: "Sign Up",
                ),
                SizedBox(height: 40),

                // OR divider
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 2.0, color: Colors.grey),
                      ),
                      Mytext(
                          text: "OR Sign In with",
                          color: Colors.grey,
                          fontsize: 20,
                          isBold: false),
                      Expanded(
                        child: Divider(thickness: 2.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // Sign in with Google or Apple buttons
                Row(
                  spacing: 10.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthServices().signInWithGoogle(),
                      imagePath: "assets/images/google.png",
                    ),
                    SquareTile(
                      onTap: () {},
                      imagePath: "assets/images/apple.png",
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Already have an account? Login here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Mytext(
                        text: "Already have an account?",
                        color: Colors.grey,
                        fontsize: 15.0,
                        isBold: false),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Mytext(
                          text: " Login here",
                          color: Colors.blue,
                          fontsize: 15.0,
                          isBold: true),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
