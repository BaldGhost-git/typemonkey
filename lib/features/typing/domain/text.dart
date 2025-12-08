import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typingapp/features/typing/domain/word.dart';

part 'text.freezed.dart';

@freezed
class TextTyping with _$TextTyping {
  @override
  final List<Word> words;
  @override
  final int currentWordIndex;

  Word get currentWord => words[currentWordIndex];
  Word? get prevWord =>
      currentWordIndex - 1 < 0 ? null : words[currentWordIndex - 1];

  int get totalCorrectChar =>
      words.fold(0, (value, element) => value + element.countCorrectChar);

  int get totalTypedChar =>
      words.fold(0, (value, element) => value + element.countTypedChar);

  const TextTyping({required this.words, required this.currentWordIndex});

  factory TextTyping.fromString(String string) {
    final words = string.split(' ').map((word) => Word.initial(word)).toList();
    return TextTyping(words: words, currentWordIndex: 0);
  }

  TextTyping typed(String char) {
    if (char.length != 1) throw 'typed can only received a single char';
    final newWord = currentWord.typed(char);
    final newList = [...words]..[currentWordIndex] = newWord;
    return copyWith(words: newList);
  }

  TextTyping delete() {
    final newWord = currentWord.deleted();
    if (newWord == currentWord) {
      return _previousWord();
    }
    final newList = [...words]..[currentWordIndex] = newWord;
    return copyWith(words: newList);
  }

  TextTyping nextWord() {
    if (!currentWord.isWordCorrect || !currentWord.isWordDone) {
      return copyWith(currentWordIndex: currentWordIndex + 1);
    }
    return copyWith(currentWordIndex: currentWordIndex + 1);
  }

  TextTyping _previousWord() {
    if (prevWord == null) return this;
    if (prevWord!.isWordCorrect && prevWord!.isWordDone) return this;
    return copyWith(currentWordIndex: currentWordIndex - 1);
  }

  TextTyping scramble() {
    final newWords = [...words];
    newWords.shuffle();
    return copyWith(words: newWords);
  }
}
