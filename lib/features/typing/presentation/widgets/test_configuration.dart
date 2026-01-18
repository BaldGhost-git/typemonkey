import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:typingapp/core/themes/sizes.dart';
import 'package:typingapp/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';

class TestConfiguration extends StatelessWidget {
  const TestConfiguration({
    super.key,
    required this.trainerState,
    required this.configVm,
  });

  final TypingTrainerState trainerState;

  final TypingTrainerViewModel configVm;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!trainerState.isRunning)
          SegmentedButton(
            segments: TestType.values
                .map(
                  (value) =>
                      ButtonSegment(value: value, label: Text(value.name)),
                )
                .toList(),
            selected: {trainerState.type},
            emptySelectionAllowed: false,
            multiSelectionEnabled: false,
            onSelectionChanged: (value) => configVm.setTypeTest(value.first),
          ),
        Gap(AppSizes.padBetweenWidgets),
        if (!trainerState.isRunning)
          SegmentedButton(
            segments: switch (trainerState.type) {
              TestType.time =>
                TimeConfig.values
                    .map(
                      (value) => ButtonSegment(
                        value: value.duration,
                        label: Text(value.duration.toString()),
                      ),
                    )
                    .toList(),
              TestType.word =>
                TextConfig.values
                    .map(
                      (value) => ButtonSegment(
                        value: value.textLength,
                        label: Text(value.textLength.toString()),
                      ),
                    )
                    .toList(),
            },
            selected: trainerState.type == TestType.word
                ? {trainerState.textLength}
                : {trainerState.testDuration},
            emptySelectionAllowed: false,
            multiSelectionEnabled: false,
            onSelectionChanged: (value) => configVm.setTypeConfig(value.first!),
          ),
      ],
    );
  }
}
