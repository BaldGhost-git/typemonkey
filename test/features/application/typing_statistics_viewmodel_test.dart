import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:typemonkey/features/typing/application/typing_statistics_viewmodel.dart';
import 'package:typemonkey/features/typing/domain/word.dart';

void main() {
  group('Test typing statistics viewmodel.', () {
    late ProviderContainer container;
    late ProviderSubscription state;
    late TypingStatisticsViewModel statVm;

    setUp(() {
      container = ProviderContainer();
      state = container.listen(typingStatisticsViewModelProvider, (_, _) {});
      statVm = container.read(typingStatisticsViewModelProvider.notifier);
    });

    tearDown(() {
      state.close();
      container.dispose(); // Also dispose the container
    });

    test('Increment correct chars count.', () {
      final int expectedCorrectChars = 2;

      for (int i = 0; i < expectedCorrectChars; i++) {
        statVm.typed(CharState.correct);
      }

      expect(
        container.read(typingStatisticsViewModelProvider).correctChars,
        expectedCorrectChars,
      );
    });

    test('Increment incorret chars count', () {
      final int expectedIncorrectChars = 4;

      for (int i = 0; i < expectedIncorrectChars; i++) {
        statVm.typed(CharState.incorrect);
      }

      expect(
        container.read(typingStatisticsViewModelProvider).incorrectChars,
        expectedIncorrectChars,
      );
    });

    test('Test WPM, Accuracy, etc. calculations.', () {
      // Arrange
      final int expectedIncorrectChars = 4;
      final int expectedCorrectChars = 50;
      final double elapsedTime = 10;
      final double expectedWpm =
          (expectedCorrectChars / 5) / (elapsedTime / 60); //60 wpm
      final double expectedRawWpm =
          ((expectedCorrectChars + expectedIncorrectChars) / 5) /
          (elapsedTime / 60); //64.8 wpm
      final double expectedAccuracy =
          (expectedCorrectChars /
              (expectedCorrectChars + expectedIncorrectChars)) *
          100; //92.59%

      // Act
      for (int i = 0; i < expectedIncorrectChars; i++) {
        statVm.typed(CharState.incorrect);
      }
      for (int i = 0; i < expectedCorrectChars; i++) {
        statVm.typed(CharState.correct);
      }
      final currentState = statVm.snapshot(10, DateTime.now());

      // Assert
      expect(currentState.incorrectChars, expectedIncorrectChars);
      expect(currentState.correctChars, expectedCorrectChars);
      expect(currentState.wpm, expectedWpm);
      expect(currentState.rawWpm, expectedRawWpm);
      expect(currentState.accuracy, expectedAccuracy);
    });
  });
}
