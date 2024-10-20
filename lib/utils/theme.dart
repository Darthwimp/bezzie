import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BezzieTheme {
  static Widget mainAppGradient({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffdbfffc),
            Color(0xffffffff),
          ],
          stops: [0.0, 1],
        ),
      ),
      child: child,
    );
  }

  static ThemeData bezzieTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.quicksand().fontFamily,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
