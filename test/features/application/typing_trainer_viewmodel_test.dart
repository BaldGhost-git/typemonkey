import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:typemonkey/features/typing/application/typing_statistics_viewmodel.dart';
import 'package:typemonkey/features/typing/application/typing_text_viewmodel.dart';
import 'package:typemonkey/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typemonkey/features/typing/domain/text.dart';
import 'package:typemonkey/features/typing/domain/typing_practice.dart';
import 'package:fake_async/fake_async.dart';
import 'package:typemonkey/features/typing/domain/typing_statistics.dart';

void main() {
  final testString = 'hello world';
  final defaultTextLength = TextConfig.twenty.textLength;
  final defaultDuration = TimeConfig.twenty.duration;

  Future<void> simulateWordTest(ProviderContainer container) async {
    final textVm = container.read(typingTextViewModelProvider.notifier);
    final currentText = await container.read(
      typingTextViewModelProvider.future,
    );
    final wordList = currentText.words.map((e) => e.word).toList().join(' ');

    // Simulate user typing
    for (String char in wordList.split('')) {
      if (char == ' ') {
        textVm.spacePressed();
        continue;
      }
      textVm.typed(char);
    }
  }

  group('Test typing trainer states and functions.', () {
    late ProviderContainer container;
    late ProviderSubscription state;
    late TypingTrainerViewModel trainerVm;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          getTextProvider.overrideWith(
            (ref, cfg) => TextTyping.fromString(testString),
          ),
          getLanguageOptsProvider.overrideWith(
            (ref) => LanguageConfig(options: ['english'], current: 'english'),
          ),
        ],
      );
      state = container.listen(typingTrainerViewModelProvider, (_, _) {});
      trainerVm = container.read(typingTrainerViewModelProvider.notifier);
    });

    tearDown(() {
      state.close();
      container.dispose();
    });

    test('Assert default values', () {
      final defaultState = TypingTrainerState(
        textLength: defaultTextLength,
        testDuration: defaultDuration,
        isRunning: false,
        isFinished: false,
        type: TestType.time,
      );
      final currentState = container.read(typingTrainerViewModelProvider);

      expect(defaultState, currentState);
    });

    test('Start training in time config', () {
      fakeAsync((async) {
        trainerVm.startTest();
        final state = container.read(typingTrainerViewModelProvider);
        expect(state.isRunning, true);
        expect(state.isFinished, false);

        async.elapse(Duration(seconds: defaultDuration));
        final finishedState = container.read(typingTrainerViewModelProvider);
        expect(finishedState.isRunning, false);
        expect(finishedState.isFinished, true);
      });
    });

    test('Start training in word config', () async {
      // Arrange test config
      trainerVm.setTypeTest(TestType.word);
      trainerVm.setTypeConfig(testString.split(' ').length);

      // Assert the test is not running
      final state = container.read(typingTrainerViewModelProvider);
      expect(state.isRunning, false);
      expect(state.isFinished, false);

      // Start test
      await simulateWordTest(container);

      // Final assert
      final finishedState = container.read(typingTrainerViewModelProvider);
      expect(finishedState.isRunning, false);
      expect(finishedState.isFinished, true);
    });

    test('Make sure resetting the test also resets the statistics', () async {
      for (int i = 0; i < 5; i++) {
        // Arrange test config
        trainerVm.setTypeTest(TestType.word);
        trainerVm.setTypeConfig(testString.split(' ').length);
        trainerVm.startTest();

        // Arrange first test data
        await simulateWordTest(container);

        // Assert current training
        final finishedState = container.read(typingTrainerViewModelProvider);
        expect(finishedState.isRunning, false);
        expect(finishedState.isFinished, true);

        trainerVm.resetTest();

        final resettedTextState = await container.read(
          typingTextViewModelProvider.future,
        );
        final resettedTrainerState = container.read(
          typingTrainerViewModelProvider,
        );
        final resettedStatisticsState = container.read(
          typingStatisticsViewModelProvider,
        );
        expect(resettedTrainerState.stats, isNull);
        expect(
          resettedStatisticsState,
          TypingStatistics(
            correctChars: 0,
            incorrectChars: 0,
            elapsedTimeInSeconds: 0,
          ),
        );
        expect(resettedTextState.currentWordIndex, 0);
        expect(resettedTextState.totalTypedChar, 0);
      }
    });
  });
}
