import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/typing/application/texts_controller.dart';
import 'package:typingapp/features/typing/presentation/widgets/test_configuration.dart';
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
    final configVm = ref.read(typingTrainerStateViewModelProvider.notifier);
    final typingState = ref.watch(typingTrainerViewModelProvider);
    final trainerState = ref.watch(typingTrainerStateViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: Text('typemonkey', style: GoogleFonts.lato())),
      body: Center(
        child: !trainerState.isFinished
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TestConfiguration(
                    trainerState: trainerState,
                    configVm: configVm,
                  ),
                  Gap(50),
                  typingState.when(
                    data: (state) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (trainerState.isRunning)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ':${trainerState.elapsedTime ?? trainerState.testDuration}',
                                style: GoogleFonts.jetBrainsMono(fontSize: 25),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TypingPractice(state: state, viewModel: vm),
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => Text('Error: $error'),
                    loading: () => CircularProgressIndicator.adaptive(),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WPM: ${trainerState.wpm.toStringAsFixed(2)}, Accuracy: ${trainerState.accuracy.toStringAsFixed(2)}%',
                  ),
                  Gap(20),
                  IconButton(
                    onPressed: configVm.resetTest,
                    icon: Icon(Icons.replay),
                  ),
                ],
              ),
      ),
    );
  }
}
