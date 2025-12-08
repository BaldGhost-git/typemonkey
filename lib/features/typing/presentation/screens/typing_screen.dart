import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/typing/application/texts_controller.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
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
    final languageVm = ref.read(languageConfigViewModelProvider.notifier);
    final language = ref.watch(languageConfigViewModelProvider);
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
                  if (!trainerState.isRunning)
                    Align(
                      alignment: Alignment.center,
                      child: DropdownMenu(
                        textStyle: GoogleFonts.jetBrainsMono(fontSize: 13),
                        initialSelection: language,
                        onSelected: (language) =>
                            languageVm.setLanguage(language!),
                        dropdownMenuEntries: LanguageConfig.values
                            .map(
                              (value) => DropdownMenuEntry(
                                value: value,
                                labelWidget: Text(
                                  value.name,
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 13,
                                  ),
                                ),
                                label: value.name,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  Gap(10),
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
                                trainerState.type == TestType.time
                                    ? ':${trainerState.elapsedTime}'
                                    : '${typingState.requireValue.currentWordIndex}/${trainerState.textLength}',
                                style: GoogleFonts.jetBrainsMono(fontSize: 25),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TypingPractice(
                            textState: state,
                            viewModel: vm,
                            trainerState: trainerState,
                          ),
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
