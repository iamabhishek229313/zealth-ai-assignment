import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zealth_ai_assign/blocs/theme_bloc/theme_bloc.dart';
import 'package:zealth_ai_assign/constants/constant_colors.dart';
import 'package:zealth_ai_assign/services/authentication_services/authentication_services.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.065,
      width: double.maxFinite,
      child: RaisedButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          AuthenticationServices.signInWithGoogle();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
        color: BlocProvider.of<ThemeBloc>(context).state.themeMode ==
                ThemeMode.dark
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
                  color: BlocProvider.of<ThemeBloc>(context).state.themeMode ==
                          ThemeMode.dark
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
    );
  }
}
