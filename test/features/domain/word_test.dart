import 'package:flutter_test/flutter_test.dart';
import 'package:typingapp/features/texts/domain/word.dart';

void main() {
  group('Testing word functions', () {
    final String str = 'Her';

    test('User typed the correct char', () {
      // Arrange
      final word = Word.initial(str);

      // Act
      final newWord = word.typed('H');
      final completedWord = newWord.typed('e').typed('r');

      // Assert
      expect(newWord.currentCharState, CharState.correct);
      expect(newWord.isWordDone, false);
      expect(newWord.isWordCorrect, false);
      expect(completedWord.isWordDone, true);
      expect(completedWord.isWordCorrect, true);
    });

    test('User typed incorrect char', () {
      // Arrange
      final word = Word.initial(str);

      // Act
      final newWord = word.typed('A');

      // Assert
      expect(newWord.currentCharState, CharState.incorrect);
    });

    test('User deleted a char', () {
      // Arrange
      final word = Word.initial(str);
      // Act
      final newWord = word.typed('H').deleted();

      // Assert
      expect(newWord.currentCharState, CharState.untyped);
    });

    test('User typed extra characters', () {
      //Arrange
      final word = Word.initial(str);

      //Act
      final newWord = word.typed('H').typed('e').typed('r').typed('s');

      //Assert
      expect(newWord.currentCharState, CharState.incorrect);
      expect(newWord.word, 'Hers');
    });

    test('User pressing backspace when user not typing anything', () {
      //Arrange
      final word = Word.initial(str);

      //Act
      final newWord = word.deleted();

      //Assert
      expect(word, newWord);
    });
  });
}
