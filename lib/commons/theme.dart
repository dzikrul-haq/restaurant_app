import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color onPrimaryColor = Colors.black;
const Color secondaryColor = Color(0xFEEE8744);
const Color primaryDarkColor = Color(0xFFCCCCCC);
const Color secondaryLightColor = Color(0xFFE07265);
const Color secondaryDarkColor = Color(0xFFC4001F);
const Color red = Color(0xFFD74141);
const Color primaryTextColor = Color(0xFF3e6ed0);
const Color secondaryTextColor = Color(0xff000000);
const Color grey = Color(0xFFBDBDBD);
const Color grey200 = Color(0xFFBABABA);
const Color darkGrey = Color(0xFF4B4B4B);

final TextStyle titleStyle = GoogleFonts.poppins(
    color: red, fontWeight: FontWeight.bold, fontSize: 28);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.oxygen(
      fontSize: 95,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5),
  headline2: GoogleFonts.oxygen(
      fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.oxygen(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.oxygen(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.oxygen(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.oxygen(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.oxygen(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.oxygen(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.roboto(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ColorScheme something = const ColorScheme(
  brightness: Brightness.light,
  primary: primaryColor,
  onPrimary: onPrimaryColor,
  secondary: secondaryColor,
  onSecondary: grey,
  error: Colors.red,
  onError: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
  surface: Colors.white,
  onSurface: Colors.white,
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: something.copyWith(secondary: secondaryLightColor),
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    elevation: 0,
    toolbarTextStyle: myTextTheme.apply(bodyColor: primaryTextColor).bodyText2,
    titleTextStyle: myTextTheme.apply(bodyColor: primaryTextColor).headline6,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.black54,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryDarkColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    elevation: 0,
    toolbarTextStyle: myTextTheme.apply(bodyColor: secondaryColor).bodyText2,
    titleTextStyle: myTextTheme.apply(bodyColor: secondaryColor).headline6,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryDarkColor),
);
