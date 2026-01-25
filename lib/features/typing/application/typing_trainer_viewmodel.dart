import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/core/config/env.dart';
import 'package:typingapp/features/typing/application/typing_statistics_viewmodel.dart';
import 'package:typingapp/features/typing/application/typing_text_viewmodel.dart';
import 'package:typingapp/features/typing/data/typing_repository.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
import 'package:typingapp/features/typing/domain/typing_statistics.dart';

part 'typing_trainer_viewmodel.g.dart';

@Riverpod(keepAlive: true)
Future<LanguageConfig> getLanguageOpts(Ref ref) {
  final repo = ref.read(typingRepositoryProvider(Env.wordApi));
  return repo.getLanguageOptions();
}

@Riverpod(keepAlive: true)
class LanguageConfigViewModel extends _$LanguageConfigViewModel {
  @override
  Future<LanguageConfig> build() async {
    final data = await ref.watch(getLanguageOptsProvider.future);
    return data;
  }

  void setLanguage(String language) {
    state = AsyncData(state.requireValue.copyWith(current: language));
  }
}

@Riverpod()
class TypingTrainerViewModel extends _$TypingTrainerViewModel {
  Timer? _timer;
  DateTime? _startedAt;
  bool get isTestActive => state.isRunning && !state.isFinished;

  @override
  TypingTrainerState build() {
    ref.listen(typingTextViewModelProvider, (prev, next) {
      // Make sure that the new data is done fetching with no errors
      if (next is AsyncData) {
        final wordsTyped = next.requireValue.currentWordIndex;
        final isCompleted = next.requireValue.currentWord.isWordCorrect;
        final startTestCheck =
            next.requireValue.totalTypedChar == 1 && !state.isRunning;

        if (startTestCheck) {
          startTest();
          return;
        }

        if (_shouldStopWordTest(wordsTyped, isCompleted)) {
          _timer!.cancel();
          final snapshot = _getStatisticSnapshot();
          state = state.copyWith(stats: [...?state.stats, snapshot]).stop();
        }
      }
    });
    return TypingTrainerState(
      textLength: TextConfig.twenty.textLength,
      testDuration: TimeConfig.twenty.duration,
      isRunning: false,
      isFinished: false,
      type: TestType.time,
    );
  }

  void startTest() {
    state = state.start();
    _startedAt = DateTime.now();
    switch (state.type) {
      case TestType.time:
        _startByTime();
      case TestType.word:
        _startByText();
    }
  }

  void _startByTime() {
    _timer?.cancel();
    state = state.copyWith(elapsedTime: state.testDuration!.toDouble());

    final oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (_) {
      final snapshot = _getStatisticSnapshot();
      state = state.copyWith(
        elapsedTime: state.elapsedTime! - 1,
        stats: [...?state.stats, snapshot],
      );
      if (_shouldStopTimeTest()) {
        state = state.stop();
        _timer!.cancel();
      };
    });
  }

  void _startByText() {
    _timer?.cancel();

    final oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (_) {
      final snapshot = _getStatisticSnapshot();
      state = state.copyWith(stats: [...?state.stats, snapshot]);
    });
  }

  bool _shouldStopTimeTest() {
    return _timer != null &&
        state.type == TestType.time &&
        _timer!.tick >= state.testDuration! &&
        isTestActive;
  }

  bool _shouldStopWordTest(int wordsTyped, bool isCompleted) {
    return state.type == TestType.word &&
        (wordsTyped >= state.textLength! ||
            (wordsTyped + 1 == state.textLength! && isCompleted)) &&
        isTestActive;
  }

  TypingStatistics _getStatisticSnapshot() {
    final timestamp = DateTime.now();
    final timeDeltaInSeconds =
        timestamp.difference(_startedAt!).inMilliseconds / 1000;
    final snapshot = ref
        .read(typingStatisticsViewModelProvider.notifier)
        .snapshot(timeDeltaInSeconds, timestamp);
    return snapshot;
  }

  void resetTest() {
    _timer?.cancel();
    ref.invalidateSelf();
    ref.invalidate(typingTextViewModelProvider);
    ref.invalidate(typingStatisticsViewModelProvider);
  }

  void setTypeTest(TestType type) {
    ref.read(typingTextViewModelProvider.notifier).scramble();
    state = state.copyWith(type: type);
  }

  void setTypeConfig(int i) {
    ref.read(typingTextViewModelProvider.notifier).scramble();
    switch (state.type) {
      case TestType.time:
        state = state.copyWith(testDuration: i);
      case TestType.word:
        state = state.copyWith(textLength: i);
    }
  }
}
