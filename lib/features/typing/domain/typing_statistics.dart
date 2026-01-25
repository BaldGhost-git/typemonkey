import 'package:freezed_annotation/freezed_annotation.dart';

part 'typing_statistics.freezed.dart';

@freezed
class TypingStatistics with _$TypingStatistics {
  final int correctChars;
  final int incorrectChars;
  final double elapsedTimeInSeconds;
  final DateTime? timestamp;

  const TypingStatistics({
    required this.correctChars,
    required this.incorrectChars,
    required this.elapsedTimeInSeconds,
    this.timestamp,
  });

  double get wpm => (correctChars / 5) / (elapsedTimeInSeconds / 60);
  double get rawWpm =>
      ((correctChars + incorrectChars) / 5) / (elapsedTimeInSeconds / 60);
  double get accuracy => (correctChars / (correctChars + incorrectChars) * 100);
}
