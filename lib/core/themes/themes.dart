import 'package:flutter/material.dart';

class AppThemes {
  static const textColor = Color(0xFFe5f1e3);
  static const backgroundColor = Color(0xFF070f06);
  static const primaryColor = Color(0xFF9be092);
  static const primaryFgColor = Color(0xFF070f06);
  static const secondaryColor = Color(0xFF288a1b);
  static const secondaryFgColor = Color(0xFF070f06);
  static const accentColor = Color(0xFF38e521);
  static const accentFgColor = Color(0xFF070f06);

  static const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    background: backgroundColor,
    onBackground: textColor,
    primary: primaryColor,
    onPrimary: primaryFgColor,
    secondary: secondaryColor,
    onSecondary: secondaryFgColor,
    tertiary: accentColor,
    onTertiary: accentFgColor,
    surface: backgroundColor,
    onSurface: textColor,
    error: Brightness.dark == Brightness.light
        ? Color(0xffB3261E)
        : Color(0xffF2B8B5),
    onError: Brightness.dark == Brightness.light
        ? Color(0xffFFFFFF)
        : Color(0xff601410),
  );
}
