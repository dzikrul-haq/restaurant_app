import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Gunakan const untuk data yang tidak berubah
const Color primaryColor = Color(0xFFFFFFFF);
const Color onPrimaryColor = Colors.black;
const Color secondaryColor = Color(0xFEEE8744);
const Color secondaryLightColor = Color(0xFFE07265);

/// Pasangkan TextTheme ke [main.dart]
final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.oxygen(
      fontSize: 95,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5
  ),
  headline2: GoogleFonts.oxygen(
      fontSize: 59,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5
  ),
  headline3: GoogleFonts.oxygen(
      fontSize: 48,
      fontWeight: FontWeight.w400
  ),
  headline4: GoogleFonts.oxygen(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25
  ),
  headline5: GoogleFonts.oxygen(
      fontSize: 24,
      fontWeight: FontWeight.w400
  ),
  headline6: GoogleFonts.oxygen(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15
  ),
  subtitle1: GoogleFonts.oxygen(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15
  ),
  subtitle2: GoogleFonts.oxygen(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1
  ),
  bodyText1: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5
  ),
  bodyText2: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25
  ),
  button: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25
  ),
  caption: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4
  ),
  overline: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5
  ),
);