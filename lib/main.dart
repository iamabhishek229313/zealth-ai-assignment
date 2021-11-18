import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zealth_ai_assign/blocs/selected_day_bloc/selected_day_bloc.dart';
import 'package:zealth_ai_assign/blocs/theme_bloc/theme_bloc.dart';
import 'package:zealth_ai_assign/constants/constant_colors.dart';
import 'package:zealth_ai_assign/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (_) => new ThemeBloc(ThemeState(ThemeMode.light))..add(ThemeLoadStarted()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => SelectedDateBloc())],
        child: BlocConsumer<ThemeBloc, ThemeState>(
          listener: (context, state) {},
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Zealth-AI(Picture of Day)',
              debugShowCheckedModeBanner: false,
              themeMode: themeState.themeMode,
              theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.white,
                  backgroundColor: Colors.white,
                  textTheme: GoogleFonts.robotoTextTheme()),
              darkTheme:
                  ThemeData(brightness: Brightness.dark, primaryColor: Colors.grey, backgroundColor: AppColors.black),
              home: SplashScreen(),
            );
          },
        ));
  }
}
