import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AppSizes {
  // Sizes for main typing screen
  static const double testConfigTopPos = 30.0;
  static const double testCounterXAxis = -0.96;
  static const double testCounterYAxis = -0.2;
  static const double testWidgetHeight = 200;
  static const double padBetweenWidgets = 15;
  static const double chartWidgetHeight = 350;
  static const double typingTextViewportHeight = testWidgetHeight * 0.6;

  // Sizes for typing text caret
  static const double caretHeight = 30;
  static const double caretWidth = 2;

  // Padding size for parent main layout
  static double horizontalMainPadding(BoxConstraints constraint) =>
      (constraint.maxWidth * 0.06).clamp(20, 120);

  // Sizes for fonts
  static const double heading2 = 30.0;
  static const double heading1 = 40.0;
  static const double menusFontSize = 16.0;
  static const double chartTitleTextSize = 14.0;
  static const double chartNumberTextSize = 12.0;

  // Measurement for test charts
  static double chartTimeInterval(double seconds) =>
      (seconds / 10).clamp(1, 6).toDouble();
  static const double primaryBarWidth = 5.0;
  static const List<int> primaryDashLine = [10, 10];
  static const double chartWpmInterval = 20.0;
  static const double chartTitleBoxSize = 40.0;
  static const double chartTitleReservedArea = 20.0;
}
