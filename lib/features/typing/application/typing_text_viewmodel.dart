import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/core/config/env.dart';
import 'package:typingapp/features/typing/application/typing_statistics_viewmodel.dart';
import 'package:typingapp/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typingapp/features/typing/data/typing_repository.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';

part 'typing_text_viewmodel.g.dart';

@Riverpod(keepAlive: true)
Future<TextTyping> getText(Ref ref, LanguageConfig language) async {
  final repo = ref.read(typingRepositoryProvider(Env.wordApi));
  return repo.getNewText(languages: language.language);
}

@Riverpod()
class TypingTextViewModel extends _$TypingTextViewModel {
  @override
  Future<TextTyping> build() async {
    final language = ref.watch(languageConfigViewModelProvider);
    final text = await ref.watch(getTextProvider(language).future);
    return text.scramble();
  }

  void typed(String value) {
    final newText = state.whenData((current) => current.typed(value));
    state = newText;
    ref
        .read(typingStatisticsViewModelProvider.notifier)
        .typed(newText.requireValue.currentWord.currentCharState);
  }

  void spacePressed() {
    state = state.whenData((current) {
      final updated = current.nextWord();
      return updated;
    });
  }

  void backspacePressed() {
    state = state.whenData((current) {
      final newState = current.delete();
      if (newState.currentWordIndex < current.currentWordIndex) {
        ref.read(typingStatisticsViewModelProvider.notifier).delete();
      }
      return newState;
    });
  }

  void scramble() {
    state = state.whenData((current) => current.scramble());
  }
}
