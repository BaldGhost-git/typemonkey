import 'package:flutter/material.dart';

class AppThemes {
  static const textColorDark = Color(0xFFe5f1e3);
  static const backgroundColorDark = Color(0xFF070f06);
  static const primaryColorDark = Color(0xFF9be092);
  static const primaryFgColorDark = Color(0xFF070f06);
  static const secondaryColorDark = Color(0xFF288a1b);
  static const secondaryFgColorDark = Color(0xFF070f06);
  static const accentColorDark = Color(0xFF38e521);
  static const accentFgColorDark = Color(0xFF070f06);
  static const textColor = Color(0xFF101b0e);
  static const backgroundColor = Color(0xFFf1f9f0);
  static const primaryColor = Color(0xFF276b1e);
  static const primaryFgColor = Color(0xFFf1f9f0);
  static const secondaryColor = Color(0xFF83e477);
  static const secondaryFgColor = Color(0xFF101b0e);
  static const accentColor = Color(0xFF31e01a);
  static const accentFgColor = Color(0xFF101b0e);

  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
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
    error: Brightness.light == Brightness.light
        ? Color(0xffB3261E)
        : Color(0xffF2B8B5),
    onError: Brightness.light == Brightness.light
        ? Color(0xffFFFFFF)
        : Color(0xff601410),
  );

  static const colorSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    background: backgroundColorDark,
    onBackground: textColorDark,
    primary: primaryColorDark,
    onPrimary: primaryFgColorDark,
    secondary: secondaryColorDark,
    onSecondary: secondaryFgColorDark,
    tertiary: accentColorDark,
    onTertiary: accentFgColorDark,
    surface: backgroundColorDark,
    onSurface: textColorDark,
    error: Brightness.dark == Brightness.light
        ? Color(0xffB3261E)
        : Color(0xffF2B8B5),
    onError: Brightness.dark == Brightness.light
        ? Color(0xffFFFFFF)
        : Color(0xff601410),
  );
}
