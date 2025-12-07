import 'dart:async';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
import 'package:typingapp/features/typing/domain/text.dart';

part 'texts_controller.g.dart';

@riverpod
Future<TextTyping> getText(Ref ref) async {
  final string = await File('assets/strings/lipsum.txt').readAsString();
  return TextTyping.fromString(string);
}

@Riverpod()
class TypingTrainerStateViewModel extends _$TypingTrainerStateViewModel {
  Timer? _timer;

  @override
  TypingTrainerState build() {
    return TypingTrainerState(
      testDuration: 15,
      wpm: 0,
      accuracy: 0,
      isRunning: false,
      isFinished: false,
    );
  }

  void startTest() {
    state = state.start();
    if (state.testDuration != null)
      _startByTime();
    else if (state.textLength != null)
      _startByText();
    else
      throw 'Must set test type first';
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

  void _startByText() {}
}

@Riverpod()
class TypingTrainerViewModel extends _$TypingTrainerViewModel {
  @override
  Future<TextTyping> build() async {
    final text = await ref.watch(getTextProvider.future);
    return text;
  }

  void typed(String value) {
    final trainer = ref.read(typingTrainerStateViewModelProvider);
    if (!trainer.isRunning) {
      ref.read(typingTrainerStateViewModelProvider.notifier).startTest();
    }
    state = state.whenData((current) => current.typed(value));
  }

  void spacePressed() {
    state = state.whenData((current) => current.nextWord());
  }

  void backspacePressed() {
    state = state.whenData((current) => current.delete());
  }
}
