enum CharState { untyped, correct, incorrect }

class Word {
  final String word;
  int currChar = 0;
  late final List<CharState> wordState;

  Word({required this.word}) {
    wordState = List.filled(word.length, CharState.untyped);
  }
}

class Text {
  final List<Word> words;
  int currWord = 0;

  Text({required this.words});

  factory Text.fromString(String string) {
    final words = string.split(' ').map((word) => Word(word: word)).toList();
    return Text(words: words);
  }

  void nextWord() {
    if (words.length - 1 == currWord) return;
    currWord++;
  }
}
