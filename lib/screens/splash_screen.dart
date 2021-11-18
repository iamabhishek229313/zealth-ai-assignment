import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zealth_ai_assign/blocs/theme_bloc/theme_bloc.dart';
import 'package:zealth_ai_assign/constants/constant_colors.dart';
import 'package:zealth_ai_assign/core/state_wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _jumpToScreen();
  }

  _jumpToScreen() {
    Timer(Duration(milliseconds: 320),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StateWrapper())));
  }

  @override
  Widget build(BuildContext context) {
    bool is_dark = (BlocProvider.of<ThemeBloc>(context).state.themeMode == ThemeMode.dark);

    return Scaffold(
        backgroundColor: is_dark ? AppColors.black : Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Zealth-AI", style: TextStyle(fontSize: 54.0, color: Colors.black, fontWeight: FontWeight.w700)),
            Text("Pic of the day.",
                style: TextStyle(fontSize: 24.0, color: Colors.indigo.shade300, fontWeight: FontWeight.w400)),
          ],
        )));
  }
}
