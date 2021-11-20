import 'package:flutter/material.dart';
import 'package:zealth_ai_assign/services/authentication_services/authentication_services.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text("Weclome to Zealth-AI",
                style: TextStyle(
                    fontSize: 42.0,
                    color: Colors.indigo.shade300,
                    fontWeight: FontWeight.bold)),
            Text("Pic of the Day", style: TextStyle(fontSize: 28.0)),
            SizedBox(
              height: 24.0,
            ),
            FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () async {
                AuthenticationServices.signInWithGoogle();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/logos/google_logo.jpg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text("Sign in with Google",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.grey)),
            Spacer(),
            Text("Made by Abhishek - 21 Nov 2021 till 3 AM"),
            Text("Assignment by Zealth-AI"),
            Text("Courtesy -  https://api.nasa.gov/"),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
