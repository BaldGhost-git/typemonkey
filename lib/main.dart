import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:typemonkey/core/themes/themes.dart';
import 'package:typemonkey/features/settings/application/settings_viewmodel.dart';
import 'package:typemonkey/features/typing/presentation/screens/typing_screen.dart';

void main() async {
  await dotenv.load();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final settings = ref.watch(settingsViewModelProvider);
        return MaterialApp(
          darkTheme: ThemeData(
            colorScheme: settings.isDarkMode
                ? AppThemes.colorSchemeDark
                : AppThemes.colorScheme,
          ),
          debugShowCheckedModeBanner: dotenv.get('ENV') != 'production',
          home: TypingScreen(),
        );
      },
    );
  }
}
