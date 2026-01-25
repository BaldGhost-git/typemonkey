import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typemonkey/features/typing/domain/typing_statistics.dart';

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

@freezed
abstract class LanguageConfig with _$LanguageConfig {
  const factory LanguageConfig({
    required List<String> options,
    required String current,
  }) = _LanguageConfig;
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
