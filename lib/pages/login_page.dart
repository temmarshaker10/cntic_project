import 'package:cntic_project/auth/auth_services.dart';
import 'package:cntic_project/components/mybutton.dart';
import 'package:cntic_project/components/mytext.dart';
import 'package:cntic_project/components/mytextfield.dart';
import 'package:cntic_project/components/squareTaile.dart';
import 'package:cntic_project/pages/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signIn() async {
    // Show loading circle while attempting to sign in
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

    // Attempt to sign in with the provided credentials
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Dismiss the loading dialog and show success message
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Success'),
      ));
    } on FirebaseAuthException catch (e) {
      // Dismiss the loading dialog
      Navigator.of(context).pop();

      // Handle specific FirebaseAuth errors
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later.';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your connection.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }

      // Show dialog with the specific error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(), // Close the dialog
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
                SizedBox(
                  height: 30,
                ),
                //logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                SizedBox(
                  height: 20,
                ),

                //Welcome Back you`ve been missed
                Mytext(
                    text: "Welcome Back you`ve been missed",
                    color: Colors.grey.shade400,
                    fontsize: 20,
                    isBold: false),
                SizedBox(
                  height: 20,
                ),

                //email textfield
                Mytextfield(
                    keyboardtype: TextInputType.emailAddress,
                    controller: email,
                    hintText: "Email",
                    obsecuretext: false),
                SizedBox(
                  height: 10,
                ),

                //password textfield
                Mytextfield(
                    keyboardtype: TextInputType.visiblePassword,
                    controller: password,
                    hintText: "Password",
                    obsecuretext: true),
                SizedBox(
                  height: 10,
                ),

                //Forgot Password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()));
                        },
                        child: Mytext(
                            text: "Forgot Password?",
                            color: Colors.grey,
                            fontsize: 15.0,
                            isBold: false),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //sign in button
                Mybutton(
                  onTap: signIn,
                  text: "Sign In",
                ),
                SizedBox(
                  height: 40,
                ),

                //OR
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    spacing: 5.0,
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                      )),
                      Mytext(
                          text: "OR Sign In with",
                          color: Colors.grey,
                          fontsize: 20,
                          isBold: false),
                      Expanded(
                          child: Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //sign in with google or apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    SquareTile(
                        onTap: () => AuthServices().signInWithGoogle(),
                        imagePath: "assets/images/google.png"),
                    SquareTile(
                        onTap: () {}, imagePath: "assets/images/apple.png")
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                //Don`t have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Mytext(
                        text: "Don`t have an account?",
                        color: Colors.grey,
                        fontsize: 15.0,
                        isBold: false),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Mytext(
                            text: " Register here",
                            color: Colors.blue,
                            fontsize: 15.0,
                            isBold: true)),
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
