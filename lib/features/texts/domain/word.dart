import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';

enum CharState { untyped, correct, incorrect }

@freezed
class Word with _$Word {
  // The actual word
  @override
  final String word;

  // Current index of the latest char the user typed
  @override
  final int currentCharIndex;

  // The actual word length
  @override
  final int realWordLength;

  // Persist state of each character if it's wrong, correct, or not typed by the user yet
  @override
  final List<CharState> charState;

  const Word({
    required this.word,
    required this.currentCharIndex,
    required this.realWordLength,
    required this.charState,
  });

  factory Word.initial(String word) {
    return Word(
      word: word,
      currentCharIndex: -1,
      realWordLength: word.length,
      charState: List.filled(word.length, CharState.untyped),
    );
  }

  Word typed(String char) {
    if (char.length != 1) throw 'typed can only received a single char';
    final nextIndex = currentCharIndex + 1; //next index to be filled;

    // If user type after the word completed
    if (nextIndex >= realWordLength) {
      final String newWord = word + char;
      return copyWith(
        word: newWord,
        charState: [...charState, CharState.incorrect],
        currentCharIndex: nextIndex,
      );
    } else {
      final newState = word[nextIndex] == char
          ? CharState.correct
          : CharState.incorrect;
      final newStateList = [...charState]..[nextIndex] = newState;
      return copyWith(currentCharIndex: nextIndex, charState: newStateList);
    }
  }

  Word deleted() {
    if (currentCharIndex < 0) return this;
    final newState = [...charState]..[currentCharIndex] = CharState.untyped;
    return copyWith(
      charState: newState,
      currentCharIndex: currentCharIndex - 1,
    );
  }

  String get currentChar =>
      currentCharIndex < 0 ? word[0] : word[currentCharIndex];

  CharState get currentCharState =>
      currentCharIndex < 0 ? charState[0] : charState[currentCharIndex];

  bool get isWordDone => realWordLength - 1 == currentCharIndex;
  bool get isWordCorrect =>
      charState.every((state) => state == CharState.correct);
}
