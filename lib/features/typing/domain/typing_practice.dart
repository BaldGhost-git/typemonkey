import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typingapp/features/typing/domain/text.dart';

part 'typing_practice.freezed.dart';

enum TestType { time, word }

enum TimeConfig {
  ten(10),
  twenty(20),
  thirty(30),
  sixty(60);

  final int duration;
  const TimeConfig(this.duration);
}

enum TextConfig {
  ten(10),
  twenty(20),
  thirty(30);

  final int textLength;
  const TextConfig(this.textLength);
}

enum LanguageConfig {
  english('english'),
  english1k('english_1k'),
  english5k('english_5k'),
  indonesian('indonesian'),
  indonesian1k('indonesian_1k');

  final String language;
  const LanguageConfig(this.language);
}

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
  @override
  final TestType type;

  TypingTrainerState({
    this.testDuration,
    this.textLength,
    required this.wpm,
    required this.accuracy,
    this.elapsedTime,
    required this.isRunning,
    required this.isFinished,
    required this.type,
  });

  TypingTrainerState start() {
    return copyWith(isFinished: false, isRunning: true);
  }

  TypingTrainerState stop(TextTyping textState, {int? duration}) {
    // WPM = (characters_typed / 5) / (time_taken_in_seconds / 60)
    // accuracy = (correct_characters / total_typed_characters) × 100

    final correctCharTyped =
        textState.totalCorrectChar + textState.currentWordIndex;
    final allCharTyped = textState.totalTypedChar + textState.currentWordIndex;
    final wpm = (correctCharTyped / 5) / ((duration ?? testDuration!) / 60);
    final accuracy = (correctCharTyped / allCharTyped) * 100;
    return copyWith(
      wpm: wpm,
      accuracy: accuracy,
      isRunning: false,
      isFinished: true,
    );
  }
}
