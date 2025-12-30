import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/features/typing/domain/typing_statistics.dart';

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
  final List<TypingStatistics>? stats;
  @override
  final double? elapsedTime;
  @override
  final bool isRunning;
  @override
  final bool isFinished;
  @override
  final TestType type;

  TypingTrainerState({
    this.testDuration,
    this.textLength,
    this.stats,
    this.elapsedTime,
    required this.isRunning,
    required this.isFinished,
    required this.type,
  });

  TypingTrainerState start() {
    return copyWith(isFinished: false, isRunning: true);
  }

  TypingTrainerState stop() {
    return copyWith(isFinished: true, isRunning: false);
  }
}
