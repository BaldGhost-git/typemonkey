import 'package:freezed_annotation/freezed_annotation.dart';

part 'typing_statistics.freezed.dart';

/// Need to create an object to represent typing statistics
/// Initial vars:
///   - correctly typed char
///   - incorrectly typed char
///   - elapsed time
///   - timestamp
/// Derived vars:
///   - wpm = (correct chars / 5) / (elapsed time / 60)
///   - raw wpm = ((correct chars + incorrectly typed char) / 5) / (elapsed time / 60)
///   - accuracy = ((correct chars / correct chars + incorrect chars) * 100)

@freezed
class TypingStatistics with _$TypingStatistics{

  final int correctChars;
  final int incorrectChars;
  final double? elapsedTimeInSeconds;
  final DateTime? timestamp;

  const TypingStatistics({
    required this.correctChars,
    required this.incorrectChars,
    this.elapsedTimeInSeconds,
    this.timestamp
  });

  double get wpm => (correctChars / 5) / (elapsedTimeInSeconds ?? 1 / 60);
  double get rawWpm => ((correctChars + incorrectChars) / 5 ) / (elapsedTimeInSeconds ?? 1 / 60);
  double get accuracy => (correctChars / (correctChars + incorrectChars) * 100);
}