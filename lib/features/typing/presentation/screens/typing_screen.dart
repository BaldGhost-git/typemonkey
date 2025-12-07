import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/features/typing/domain/word.dart';
import 'package:typingapp/features/typing/application/texts_controller.dart';
import 'package:typingapp/features/typing/presentation/widgets/typing_practice_widget.dart';

class TypingScreen extends ConsumerStatefulWidget {
  const TypingScreen({super.key});

  @override
  ConsumerState<TypingScreen> createState() => _TypingScreenState();
}

class _TypingScreenState extends ConsumerState<TypingScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.read(typingTrainerViewModelProvider.notifier);
    final typingState = ref.watch(typingTrainerViewModelProvider);
    final trainerState = ref.watch(typingTrainerStateViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: Text('typemonkey', style: GoogleFonts.lato())),
      body: Center(
        child: !trainerState.isFinished
            ? typingState.when(
                data: (state) => Column(
                  children: [
                    Text(
                      ':${trainerState.elapsedTime ?? trainerState.testDuration}',
                    ),
                    TypingPractice(state: state, viewModel: vm),
                  ],
                ),
                error: (error, stackTrace) => Text('Error: $error'),
                loading: () => CircularProgressIndicator.adaptive(),
              )
            : Text(
                'WPM: ${trainerState.wpm.toStringAsFixed(2)}, Accuracy: ${trainerState.accuracy.toStringAsFixed(2)}%',
              ),
      ),
    );
  }
}
