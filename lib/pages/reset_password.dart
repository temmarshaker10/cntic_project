import 'package:cntic_project/components/mybutton.dart';
import 'package:cntic_project/components/mytext.dart';
import 'package:cntic_project/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController email = TextEditingController();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Request notification permissions
    messaging.requestPermission();

    // Initialize local notifications
    var androidInit = new AndroidInitializationSettings('google');
    var initSettings = InitializationSettings(android: androidInit);
    flutterLocalNotificationsPlugin.initialize(initSettings);

    // Get the FCM token
    messaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    // Handle background notifications
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      // Show error if email is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter your email address.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return; // Exit the function if email is empty
    }

    // Show progress dialog
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop(); // Close the progress dialog

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('A password reset email has been sent to $email.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );

      // Show notification
      _showNotification("Password Reset", "An email has been sent to $email");
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); // Close the progress dialog

      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = 'The email address is invalid.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email address.';
      } else {
        errorMessage = 'An unexpected error occurred. Please try again later.';
      }

      // Show error dialog with the specific error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Function to show a local notification
  void _showNotification(String title, String body) async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Mytext(
            text: "Reset Your Password",
            color: Colors.white,
            fontsize: 20.0,
            isBold: true),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Mytext(
                text: "Enter your email to reset the password",
                color: Colors.black,
                fontsize: 20,
                isBold: false),
            SizedBox(height: 20), // Add space between text and text field
            Mytextfield(
                controller: email,
                hintText: "Email",
                obsecuretext: false,
                keyboardtype: TextInputType.emailAddress),
            SizedBox(height: 20), // Add space between text field and button
            MaterialButton(
                onPressed: () => resetPassword(
                    email.text), // Call the function with email input
                child: Mytext(
                    text: "Reset Password",
                    color: Colors.black,
                    fontsize: 20,
                    isBold: true)),
          ],
        ),
      ),
    );
  }
}
