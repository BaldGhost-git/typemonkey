import 'package:flutter/material.dart';
import 'package:typingapp/core/themes/sizes.dart';
import 'package:typingapp/core/themes/themes.dart';

class CustomCaret extends StatefulWidget {
  const CustomCaret({super.key});

  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<CustomCaret>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animationController.repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        context,
        alignment: 0.5,
        duration: Duration(milliseconds: 120),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        height: AppSizes.caretHeight,
        width: AppSizes.caretWidth,
        color: AppThemes.accentColor,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
