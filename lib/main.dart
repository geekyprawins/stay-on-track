import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'ui/app_colors.dart';
import 'ui/home/home_page.dart';

void main() {
  runApp(const TheMorningApp());
}

class TheMorningApp extends StatelessWidget {
  const TheMorningApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final w700BitterFont = GoogleFonts.bitter(
      fontWeight: FontWeight.w700,
    );
    return MaterialApp(
      title: 'The Morning App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        primaryColor: AppColors.primary,
        primaryColorDark: AppColors.primaryDark,
        accentColor: AppColors.secondaryColor,
        appBarTheme: const AppBarTheme(
          brightness: Brightness.dark,
        ),
        primaryTextTheme: TextTheme(
          headline6: w700BitterFont,
        ),
        textTheme: TextTheme(
          subtitle1: w700BitterFont.apply(color: AppColors.black),
          headline6: w700BitterFont.apply(color: AppColors.black),
          bodyText2: w700BitterFont.apply(color: AppColors.black),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
