import 'package:flutter/material.dart';

const String _fontFamily = 'Mont';
const String _fontFamilySemibold = 'Mont_Semibold';
const String _fontFamilyBold = 'Mont_Bold';

class MainTheme {
  static const Color white = Color(0xFFFFFFFF);
  static const Color shadow = Color(0x33262626);
  static const Color mainBackgroundColor = white;
  static const Color textColor = Color(0xFF071E23);
  static const Color accentColor = Color(0xFF0EA652);
  static const Color secondaryColor = Color(0xFFE3F2FD);
  // static const Color fizikiLightColor = Color(0xFFDFFFE4);
  static const Color grayFonColor = Color(0xFFF3F1F8);
  static const Color grayFon1Color = Color(0xFFF3F1F8);
  static const Color grayFon2Color = Color(0xFFE1E0E5);
  static const Color grayFon3Color = Color(0xFF88868D);
  static const Color grayFonDarkestColor = Color(0xFF4F4F4F);

  static const Color intenseBlueColor = Color(0xFF107AF6);
  static const Color extraBlueColor = Color(0xFF51ABFF);
  static const Color extraBlueLightColor = Color(0xFFE2F8FF);
  static const Color extraRedColor = Color(0xFFF3612C);
  static const Color extraRedLightColor = Color(0xFFFFEAE2);
  static const Color extraYellowColor = Color(0xFFFFB428);
  static const Color extraYellowLightColor = Color(0xFFFFF7E9);
  static const Color nightColor = Color(0xFF5282C9);

  static ThemeData terraTheme = ThemeData(
    colorScheme: const ColorScheme.light(
        primary: accentColor,
        onPrimary: mainBackgroundColor,
        secondary: secondaryColor,
        onSecondary: textColor,
        background: mainBackgroundColor,
        onBackground: textColor,
        outline: grayFon2Color,
        surface: mainBackgroundColor,
        inversePrimary: grayFon2Color,
        onSurface: grayFon3Color),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor,
        selectionColor: accentColor.withAlpha(100),
        selectionHandleColor: accentColor),
    textTheme: TextTheme(
        bodyMedium: textMain14,
        bodySmall: textMain12,
        bodyLarge: textMain16,
        labelSmall: semibold12,
        labelMedium: semibold14,
        labelLarge: semibold16,
        titleSmall: bold12,
        titleMedium: bold14,
        titleLarge: bold16,
        headlineLarge: bold18
        ),
  );

  static TextStyle textMain14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textColor,
    letterSpacing: 0.02,
    fontStyle: FontStyle.normal,
    fontFamily: _fontFamily,
    decoration: TextDecoration.none,
  );
  static TextStyle textMain16 = textMain14.copyWith(fontSize: 16);
  static TextStyle textMain12 = textMain14.copyWith(fontSize: 12);
  static TextStyle textMain10 = textMain14.copyWith(fontSize: 10);

  static TextStyle semibold14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: textColor,
    fontFamily: _fontFamilySemibold,
    letterSpacing: 0.02,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none,
  );
  static TextStyle semibold16 = semibold14.copyWith(fontSize: 16);
  static TextStyle semibold12 = semibold14.copyWith(fontSize: 12);

  static TextStyle bold14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: textColor,
    letterSpacing: 0.02,
    fontFamily: _fontFamilyBold,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none,
  );
  static TextStyle bold16 = bold14.copyWith(fontSize: 16);
  static TextStyle bold18 = bold14.copyWith(fontSize: 18);
  static TextStyle bold12 = bold14.copyWith(fontSize: 12);
}
