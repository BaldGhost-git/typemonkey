import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/typing/application/typing_text_viewmodel.dart';
import 'package:typingapp/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
import 'package:typingapp/features/typing/presentation/widgets/typing_results.dart';
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
    final vm = ref.read(typingTextViewModelProvider.notifier);
    final configVm = ref.read(typingTrainerViewModelProvider.notifier);
    final languageVm = ref.read(languageConfigViewModelProvider.notifier);
    final textState = ref.watch(typingTextViewModelProvider);
    final trainerState = ref.watch(typingTrainerViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: Text('typemonkey', style: GoogleFonts.lato())),
      body: Center(
        child: !trainerState.isFinished
            ? Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  Positioned(
                    top: 30,
                    child: TestConfiguration(
                      trainerState: trainerState,
                      configVm: configVm,
                    ),
                  ),
                  // Gap(50),
                  if (trainerState.isRunning)
                    Align(
                      alignment: Alignment(-0.97, -0.45),
                      child: Text(
                        trainerState.type == TestType.time
                            ? ':${trainerState.elapsedTime}'
                            : '${textState.requireValue.currentWordIndex}/${trainerState.textLength}',
                        style: GoogleFonts.jetBrainsMono(fontSize: 25),
                      ),
                    ),
                  Positioned.fill(
                    top: 200,
                    bottom: 100,
                    child: Column(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final language = ref.watch(
                              languageConfigViewModelProvider,
                            );
                            return DropdownMenu(
                              textStyle: GoogleFonts.jetBrainsMono(
                                fontSize: 13,
                              ),
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
                            );
                          },
                        ),
                        Gap(15),
                        textState.when(
                          data: (state) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                            ),
                            child: TypingPractice(
                              textState: state,
                              viewModel: vm,
                              trainerState: trainerState,
                            ),
                          ),
                          error: (error, stackTrace) => Text('Error: $error'),
                          loading: () => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(height: 300, child: TypingResults(state: trainerState, vm: configVm)),
            ),
      ),
    );
  }
}
