import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/texts/domain/text.dart';

part 'texts_controller.g.dart';

class TypingTrainerState {
  final TextTyping currentText;
  int wpm = 0;
  String currentTyped = '';

  TypingTrainerState({required this.currentText});
}

@riverpod
Future<TextTyping> getText(Ref ref) async {
  final string = await File('assets/strings/lipsum.txt').readAsString();
  return TextTyping.fromString(string);
}

@Riverpod()
class TypingTrainerViewModel extends _$TypingTrainerViewModel {
  @override
  Future<TypingTrainerState> build() async {
    final text = await ref.watch(getTextProvider.future);
    return TypingTrainerState(currentText: text);
  }

  // void userTyped(String key) {
  //   state.requireValue.currentTyped += key;
  //   print(state.requireValue.currentTyped);
  // }

  void typedOnChanged(String value) {
    if (state.requireValue.currentTyped.isEmpty && value.isEmpty) return;
    state.requireValue.currentTyped = value;
    final lastChar = value.substring(value.length - 1);
    // state.requireValue.currentText.typed(lastChar);
    // state = state;
  }

  void spacePressed() {
    state.requireValue.currentText.nextWord();
    state = state;
  }

  // void backspacePressed() {
  //   state.requireValue.currentText.delete();
  //   state = state;
  // }
}
