import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typingapp/features/typing/domain/text.dart';

part 'typing_practice.freezed.dart';

@freezed
class TypingTrainerState with _$TypingTrainerState {
  @override
  final int? testDuration;
  @override
  final int? textLength;
  @override
  final double wpm;
  @override
  final double accuracy;
  @override
  final int? elapsedTime;
  @override
  final bool isRunning;
  @override
  final bool isFinished;

  TypingTrainerState({
    this.testDuration,
    this.textLength,
    required this.wpm,
    required this.accuracy,
    this.elapsedTime,
    required this.isRunning,
    required this.isFinished,
  });

  TypingTrainerState start() {
    return TypingTrainerState(
      testDuration: testDuration,
      textLength: textLength,
      wpm: 0,
      accuracy: 0,
      isRunning: true,
      isFinished: false,
    );
  }

  TypingTrainerState stop(TextTyping textState, {int? duration}) {
    // WPM = (characters_typed / 5) / (time_taken_in_seconds / 60)
    // accuracy = (correct_characters / total_typed_characters) × 100

    final correctCharTyped =
        textState.totalCorrectChar + textState.currentWordIndex;
    final allCharTyped = textState.totalTypedChar + textState.currentWordIndex;
    final wpm = (correctCharTyped / 5) / (duration ?? testDuration! / 60);
    final accuracy = (correctCharTyped / allCharTyped) * 100;
    return copyWith(
      wpm: wpm,
      accuracy: accuracy,
      isRunning: false,
      isFinished: true,
    );
  }
}
