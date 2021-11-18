import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zealth_ai_assign/blocs/theme_bloc/theme_bloc.dart';
import 'package:zealth_ai_assign/constants/constant_colors.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Weclome to Zealth-AI",
                style: TextStyle(fontSize: 42.0, color: Colors.indigo.shade300, fontWeight: FontWeight.bold)),
            Text("Let's get started with a quick Authentication.", style: TextStyle(fontSize: 28.0)),
            SizedBox(
              height: screenHeight * 0.065,
              width: double.maxFinite,
              child: RaisedButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  AuthenticationServices.signInWithGoogle();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                color: BlocProvider.of<ThemeBloc>(context).state.themeMode == ThemeMode.dark
                    ? Colors.white
                    : AppColors.black,
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 0.6,
                      child: Container(
                        child: Image.asset(
                          'assets/logos/google_logo.jpg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: BlocProvider.of<ThemeBloc>(context).state.themeMode == ThemeMode.dark
                              ? Colors.black
                              : Colors.white,
                          fontSize: 24.0),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 32.0,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
