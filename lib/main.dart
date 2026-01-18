import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typingapp/core/config/env.dart';
import 'package:typingapp/core/themes/themes.dart';
import 'package:typingapp/features/typing/presentation/screens/typing_screen.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(colorScheme: AppThemes.colorScheme),
      debugShowCheckedModeBanner: Env.env != 'production',
      home: TypingScreen(),
    );
  }
}
