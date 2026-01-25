import 'package:flutter_test/flutter_test.dart';
import 'package:typemonkey/features/typing/domain/word.dart';

void main() {
  group('Testing word functions', () {
    final String str = 'Her';

    test('User typed the correct char', () {
      // Arrange
      final word = Word.initial(str);

      // Act
      final newWord = word.typed('H');

      // Assert
      expect(newWord.currentCharState, CharState.correct);
      expect(newWord.isWordDone, false);
      expect(newWord.isWordCorrect, false);
    });

    test('User completed the word correctly', () {
      // Arrange
      final word = Word.initial(str);

      // Act
      final newWord = word.typed('H').typed('e').typed('r');

      // Assert
      expect(newWord.isWordDone, true);
      expect(newWord.isWordCorrect, true);
    });

    test('User typed incorrect char', () {
      // Arrange
      final word = Word.initial(str);

      // Act
      final newWord = word.typed('A');

      // Assert
      expect(newWord.currentCharState, CharState.incorrect);
    });

    test('User completed the word incorrectly', () {
      // Arrange
      final word = Word.initial(str);

      // Act
      final newWord = word.typed('A').typed('e').typed('r');

      // Assert
      expect(newWord.isWordDone, true);
      expect(newWord.isWordCorrect, false);
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
      expect(newWord.realWordLength, lessThan(newWord.countTypedChar));
      expect(newWord.realWordLength, lessThan(newWord.word.length));
      expect(newWord.word, 'Hers');
    });

    test(
      'User typed extra characters then typed backspace should delete extra characters',
      () {
        //Arrange
        final word = Word.initial(str);

        //Act
        final newWord = word
            .typed('H')
            .typed('e')
            .typed('r')
            .typed('s')
            .deleted();

        //Assert
        expect(newWord.word, str);
        expect(newWord.charState.length, str.length);
      },
    );

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
