import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typingapp/features/texts/domain/word.dart';

part 'text.freezed.dart';

@freezed
class TextTyping with _$TextTyping {
  @override
  final List<Word> words;
  @override
  final int currentWordIndex;

  // true: Word is incorrect or incomplete, and to be underlined if user go to the next word
  // false: Word is correct and complete, and not underlined if user go to the next word
  @override
  final List<bool> wordsIncompleteness;

  Word get currentWord => words[currentWordIndex];
  bool get isCurrentWordIncomplete => wordsIncompleteness[currentWordIndex];
  Word? get prevWord =>
      currentWordIndex - 1 < 0 ? null : words[currentWordIndex - 1];

  const TextTyping({
    required this.words,
    required this.currentWordIndex,
    required this.wordsIncompleteness,
  });

  factory TextTyping.fromString(String string) {
    final words = string.split(' ').map((word) => Word.initial(word)).toList();
    return TextTyping(
      words: words,
      currentWordIndex: 0,
      wordsIncompleteness: List.filled(words.length, false),
    );
  }

  TextTyping typed(String char) {
    if (char.length != 1) throw 'typed can only received a single char';
    final newWord = currentWord.typed(char);
    final newList = [...words]..[currentWordIndex] = newWord;
    return copyWith(words: newList);
  }

  // void delete() {
  //   currentWord.deleted();
  // }

  TextTyping nextWord() {
    if (!currentWord.isWordCorrect || !currentWord.isWordDone) {
      final newWordsState = [...wordsIncompleteness]..[currentWordIndex] = true;
      return copyWith(
        currentWordIndex: currentWordIndex + 1,
        wordsIncompleteness: newWordsState,
      );
    }
    return copyWith(currentWordIndex: currentWordIndex + 1);
  }

  TextTyping previousWord() {
    if (prevWord == null) return this;
    if (prevWord!.isWordCorrect && prevWord!.isWordDone) return this;
    return copyWith(currentWordIndex: currentWordIndex - 1);
  }
}
