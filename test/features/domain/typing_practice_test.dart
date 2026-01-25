import 'package:flutter_test/flutter_test.dart';
import 'package:typemonkey/features/typing/domain/typing_practice.dart';

void main() {
  group('Testing training states', () {
    final state = TypingTrainerState(
      isRunning: false,
      isFinished: false,
      type: TestType.time,
    );

    test('Start typing practice', () {
      // Act
      final newState = state.start();

      // Assert
      expect(newState.isRunning, true);
      expect(newState.isFinished, false);
    });

    test('Start typing practice', () {
      // Act
      final newState = state.stop();

      // Assert
      expect(newState.isRunning, false);
      expect(newState.isFinished, true);
    });
  });
}
