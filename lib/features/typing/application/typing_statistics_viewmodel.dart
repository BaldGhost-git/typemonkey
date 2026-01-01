import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/typing/domain/typing_statistics.dart';
import 'package:typingapp/features/typing/domain/word.dart';

part 'typing_statistics_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class TypingStatisticsViewModel extends _$TypingStatisticsViewModel {
  int _currIndex = 0;
  List<bool> countState = [];

  @override
  TypingStatistics build() {
    return TypingStatistics(correctChars: 0, incorrectChars: 0, elapsedTimeInSeconds: 0);
  }

  void typed(CharState charState) {
    // countState[_currIndex]
    switch (charState) {
      case CharState.correct:
        // if (countState[_currIndex]) return;
        state = state.copyWith(correctChars: state.correctChars + 1);
      case CharState.incorrect: 
        state = state.copyWith(incorrectChars: state.incorrectChars + 1);
      default: throw UnimplementedError();
    }
    // _currIndex++;
  }

  TypingStatistics snapshot(double elapsedTime, DateTime timestamp) {
    final snapshot = state.copyWith(elapsedTimeInSeconds: elapsedTime, timestamp: timestamp);
    return snapshot;
  }

  void delete() {
    if (_currIndex - 1 < 0) return;
    _currIndex--;
  }
}