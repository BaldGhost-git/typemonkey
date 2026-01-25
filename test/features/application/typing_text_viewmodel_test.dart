import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:typingapp/features/typing/application/typing_text_viewmodel.dart';
import 'package:typingapp/features/typing/application/typing_trainer_viewmodel.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
import 'package:typingapp/features/typing/domain/word.dart';

void main() {
  final testString = 'hello world';
  group('Test text state viewmodel.', () {
    late ProviderContainer container;
    late ProviderSubscription state;
    late TypingTextViewModel textVm;

    setUp(() {
      container = ProviderContainer(overrides: [
          getTextProvider.overrideWith(
            (ref, cfg) => TextTyping.fromString(testString),
          ),
          getLanguageOptsProvider.overrideWith(
            (ref) => LanguageConfig(options: ['english'], current: 'english'),
          ),
        ],);
      state = container.listen(typingTextViewModelProvider, (_, _) {});
      textVm = container.read(typingTextViewModelProvider.notifier);
    });

    tearDown(() {
      state.close();
      container.dispose();
    });

    test('Assert default state',  () async {
      final state = await container.read(typingTextViewModelProvider.future);
      final List<String> wordList = state.words.map((word) => word.word).toList();
      final testWordList = testString.split(' ');
      expect(state, isNotNull);
      expect(wordList.every((word) => testWordList.contains(word)), true);
    });

    test('typed starts test and updates current word state.', () async {

      final firstState = await container.read(typingTextViewModelProvider.future);
      final firstLetter = firstState.currentWord.word[0];

      textVm.typed(firstLetter);

      final textState = container.read(typingTextViewModelProvider);

      expect(textState.hasValue, true);
      expect(textState.value!.currentWord.charState.first, CharState.correct);
    });

    test('spacePressed moves to next word.', () async {

      final state = await container.read(typingTextViewModelProvider.future);
      final firstWord = state.currentWord;

      for (var char in firstWord.word.split('')) {
        textVm.typed(char);
      }
      textVm.spacePressed();

      final currentState = container.read(typingTextViewModelProvider).requireValue;
      expect(currentState.currentWordIndex, 1);
    });

    test('backspacePressed deletes previous character.', () async {

      final state = await container.read(typingTextViewModelProvider.future);
      final firstWord = state.currentWord;

      textVm.typed(firstWord.word[0]);
      textVm.backspacePressed();

      final currentState = container.read(typingTextViewModelProvider).requireValue;
      expect(currentState.currentWord.charState.first, CharState.untyped);
    });

    test('backspacePressed disable jumping to previous word if previous word is correct.', () async {

      final state = await container.read(typingTextViewModelProvider.future);
      final firstWord = state.currentWord;

      for (var char in firstWord.word.split('')) {
        textVm.typed(char);
      }
      textVm.spacePressed();
      textVm.backspacePressed();

      final currentState = container.read(typingTextViewModelProvider).requireValue;
      expect(currentState.currentWordIndex, 1);
    });

    test('backspacePressed allows jumping to previous word if previous word is incorrect.', () async {
      // Initialize state
      await container.read(typingTextViewModelProvider.future);

      textVm.spacePressed();
      final firstState = container.read(typingTextViewModelProvider).requireValue;
      textVm.backspacePressed();
      final secondState = container.read(typingTextViewModelProvider).requireValue;

      expect(firstState.currentWordIndex, 1);
      expect(secondState.currentWordIndex, 0);
    });
  });
}