import 'package:flutter/material.dart';

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
      if (Scrollable.of(context) != null) {
        Scrollable.ensureVisible(
          context,
          alignment: 0.5,
          duration: Duration(milliseconds: 120),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(height: 30, width: 2, color: Colors.red),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
