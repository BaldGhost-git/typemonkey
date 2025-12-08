import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/typing/data/typing_repository.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
import 'package:typingapp/features/typing/domain/text.dart';

part 'texts_controller.g.dart';

@Riverpod(keepAlive: true)
Future<TextTyping> getText(Ref ref, LanguageConfig language) async {
  final repo = ref.read(typingRepositoryProvider('https://monkeytype.com'));
  return repo.getNewText(languages: language.language);
}

@Riverpod(keepAlive: true)
class LanguageConfigViewModel extends _$LanguageConfigViewModel {
  @override
  LanguageConfig build() {
    return LanguageConfig.english;
  }

  void setLanguage(LanguageConfig language) {
    state = language;
  }
}

@Riverpod()
class TypingTrainerStateViewModel extends _$TypingTrainerStateViewModel {
  Timer? _timer;
  DateTime? _startedAt;

  @override
  TypingTrainerState build() {
    return TypingTrainerState(
      textLength: TextConfig.twenty.textLength,
      testDuration: TimeConfig.twenty.duration,
      wpm: 0,
      accuracy: 0,
      isRunning: false,
      isFinished: false,
      type: TestType.time,
    );
  }

  void startTest() {
    state = state.start();
    switch (state.type) {
      case TestType.time:
        _startByTime();
      case TestType.word:
        _startByText();
    }
  }

  void _startByTime() {
    _timer?.cancel();
    state = state.copyWith(elapsedTime: state.testDuration);

    final oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (time) {
      if (time.tick < state.testDuration!) {
        state = state.copyWith(elapsedTime: state.elapsedTime! - 1);
      } else {
        final textState = ref.read(typingTrainerViewModelProvider).requireValue;
        _timer?.cancel();
        state = state.stop(textState);
      }
    });
  }

  void _startByText() {
    _startedAt = DateTime.now();
  }

  void resetTest() {
    _timer?.cancel();
    _startedAt = null;
    ref.invalidateSelf();
    ref.invalidate(typingTrainerViewModelProvider);
  }

  void setTypeTest(TestType type) {
    ref.read(typingTrainerViewModelProvider.notifier).scramble();
    state = state.copyWith(type: type);
  }

  void setTypeConfig(int i) {
    ref.read(typingTrainerViewModelProvider.notifier).scramble();
    switch (state.type) {
      case TestType.time:
        state = state.copyWith(testDuration: i);
      case TestType.word:
        state = state.copyWith(textLength: i);
    }
  }

  void onTextProgress(TextTyping text) {
    if (state.type != TestType.word || !state.isRunning) return;
    if (state.textLength == null) return;

    final wordsTyped = text.currentWordIndex;
    final isCompleted = text.currentWord.isWordCorrect;
    if (wordsTyped >= state.textLength! ||
        (wordsTyped + 1 == state.textLength! && isCompleted)) {
      final seconds = DateTime.now().difference(_startedAt!).inSeconds;
      // `duration` is in minutes, to match your stop() formula.
      state = state.stop(text, duration: seconds);
    }
  }
}

@Riverpod()
class TypingTrainerViewModel extends _$TypingTrainerViewModel {
  @override
  Future<TextTyping> build() async {
    final language = ref.watch(languageConfigViewModelProvider);
    final text = await ref.watch(getTextProvider(language).future);
    return text.scramble();
  }

  void typed(String value) {
    final trainer = ref.read(typingTrainerStateViewModelProvider);
    final trainerVm = ref.read(typingTrainerStateViewModelProvider.notifier);
    if (!trainer.isRunning) {
      ref.read(typingTrainerStateViewModelProvider.notifier).startTest();
    }
    state = state.whenData((current) {
      final updated = current.typed(value);
      trainerVm.onTextProgress(updated);
      return updated;
    });
  }

  void spacePressed() {
    final trainerVm = ref.read(typingTrainerStateViewModelProvider.notifier);

    state = state.whenData((current) {
      final updated = current.nextWord();
      trainerVm.onTextProgress(updated);
      return updated;
    });
  }

  void backspacePressed() {
    state = state.whenData((current) => current.delete());
  }

  void scramble() {
    state = state.whenData((current) => current.scramble());
  }
}
