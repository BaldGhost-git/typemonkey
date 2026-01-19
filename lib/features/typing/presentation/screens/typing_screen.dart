import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/core/themes/sizes.dart';
import 'package:typingapp/core/themes/styles.dart';
import 'package:typingapp/features/settings/application/settings_viewmodel.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalMainPadding(constraints),
          ),
          child: Center(
            child: !trainerState.isFinished
                ? Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.directional(
                          top: AppSizes.testConfigTopPos,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: TestConfiguration(
                            trainerState: trainerState,
                            configVm: configVm,
                          ),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final settingsVm = ref.read(
                            settingsViewModelProvider.notifier,
                          );
                          final settings = ref.watch(settingsViewModelProvider);
                          return Padding(
                            padding: EdgeInsetsGeometry.directional(
                              top: AppSizes.testConfigTopPos,
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: settingsVm.flipScheme,
                                icon: Icon(
                                  settings.isDarkMode
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: AppSizes.testWidgetHeight,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  if (trainerState.isRunning)
                                    Text(
                                      trainerState.type == TestType.time
                                          ? ':${trainerState.elapsedTime?.toInt().toString()}'
                                          : '${textState.requireValue.currentWordIndex}/${trainerState.textLength}',
                                      style: AppStyles.primaryHeading2,
                                    ),
                                  Expanded(
                                    child: Center(
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          final language = ref.watch(
                                            languageConfigViewModelProvider,
                                          );
                                          return DropdownMenu(
                                            textStyle: AppStyles.menusText,
                                            initialSelection: language,
                                            onSelected: (language) => languageVm
                                                .setLanguage(language!),
                                            dropdownMenuEntries: LanguageConfig
                                                .values
                                                .map(
                                                  (value) => DropdownMenuEntry(
                                                    value: value,
                                                    labelWidget: Text(
                                                      value.name,
                                                      style:
                                                          AppStyles.menusText,
                                                    ),
                                                    label: value.name,
                                                  ),
                                                )
                                                .toList(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(AppSizes.padBetweenWidgets),
                              textState.when(
                                data: (state) => TypingPractice(
                                  textState: state,
                                  viewModel: vm,
                                  trainerState: trainerState,
                                ),
                                error: (error, stackTrace) =>
                                    Text('Error: $error'),
                                loading: () => Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: AppSizes.chartWidgetHeight,
                    child: TypingResults(state: trainerState, vm: configVm),
                  ),
          ),
        ),
      ),
    );
  }
}
