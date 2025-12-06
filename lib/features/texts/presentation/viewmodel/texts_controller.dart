import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/texts/domain/text.dart';

part 'texts_controller.g.dart';

@riverpod
Future<TextTyping> getText(Ref ref) async {
  final string = await File('assets/strings/lipsum.txt').readAsString();
  return TextTyping.fromString(string);
}

@Riverpod()
class TypingTrainerViewModel extends _$TypingTrainerViewModel {
  @override
  Future<TextTyping> build() async {
    final text = await ref.watch(getTextProvider.future);
    return text;
  }

  void typed(String value) {
    state = state.whenData((current) => current.typed(value));
  }

  void spacePressed() {
    state = state.whenData((current) => current.nextWord());
  }

  void backspacePressed() {
    state = state.whenData((current) => current.delete());
  }
}
