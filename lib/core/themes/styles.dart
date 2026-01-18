import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/core/themes/sizes.dart';

class AppStyles {
  static final TextStyle primaryFont = GoogleFonts.jetBrainsMono();
  static final TextStyle primaryHeading1 = primaryFont.copyWith(
    fontSize: AppSizes.heading1,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle primaryHeading2 = primaryFont.copyWith(
    fontSize: AppSizes.heading2,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle menusText = primaryFont.copyWith(
    fontSize: AppSizes.menusFontSize,
  );
  static final TextStyle chartTitle = primaryFont.copyWith(
    fontSize: AppSizes.chartTitleTextSize,
  );

  static final TextStyle chartNumbers = primaryFont.copyWith(
    fontSize: AppSizes.chartNumberTextSize,
  );
}
