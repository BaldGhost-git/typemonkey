import 'package:flutter_test/flutter_test.dart';
import 'package:typingapp/features/texts/domain/text.dart';
import 'package:typingapp/features/texts/domain/word.dart';

void main() {
  group('Test Text class functions', () {
    final String str = 'He is him';

    test('Current word completed and correct, then press space', () {
      // Arrange
      final text = TextTyping.fromString(str);

      //Act
      final textOnSecondWord = text.typed('H').typed('e').nextWord();

      //Assert
      expect(textOnSecondWord.currentWordIndex, 1);
      expect(
        textOnSecondWord.prevWord!.isWordDone &&
            textOnSecondWord.prevWord!.isWordCorrect,
        true,
      );
    });

    test('Current word completed but incorrect, then press space', () {
      //Arrange
      final text = TextTyping.fromString(str);

      //Act
      final textOnSecondWord = text.typed('H').typed('r').nextWord();

      //Assert
      expect(textOnSecondWord.currentWordIndex, 1);
      expect(textOnSecondWord.prevWord!.isWordCorrect, false);
      expect(textOnSecondWord.prevWord!.isWordDone, true);
    });

    test('Current word not completed and incorrect, then press space', () {
      //Arrange
      final text = TextTyping.fromString(str);

      //Act
      final textOnSecondWord = text.typed('H').nextWord();

      //Assert
      expect(textOnSecondWord.currentWordIndex, 1);
      expect(textOnSecondWord.prevWord!.isWordCorrect, false);
      expect(textOnSecondWord.prevWord!.isWordDone, false);
    });

    test(
      'User pressing backspace to a completed & correct word should be denied',
      () {
        //Arrange
        final text = TextTyping.fromString(str);

        //Act
        final newText = text.typed('H').typed('e').nextWord();
        final anotherText = newText.delete();

        //Assert
        expect(newText.currentWordIndex, 1);
        expect(anotherText.currentWordIndex, 1);
        expect(anotherText, newText);
      },
    );

    test(
      'User pressing backspace to an incorrect or incomplete word should be allowed',
      () {
        //Arrange
        final text = TextTyping.fromString(str);

        //Act
        final newText = text.typed('H').typed('r').nextWord().delete();

        //Assert
        expect(newText.currentWordIndex, 0);
      },
    );

    test('Text should update it\'s state after several backspace', () {
      //Arrange
      final text = TextTyping.fromString(str);

      //Act
      final firstTest = text
          .typed('H')
          .typed('r')
          .nextWord()
          .typed('i')
          .typed('s')
          .delete();

      final secondTest = firstTest.delete();
      final thirdTest = secondTest.delete();

      //Assert
      expect(firstTest.currentWordIndex, 1);
      expect(
        firstTest.currentWord.charState[firstTest.currentWord.currentCharIndex +
            1],
        CharState.untyped,
      );

      expect(secondTest.currentWordIndex, 1);
      expect(
        secondTest
            .currentWord
            .charState[firstTest.currentWord.currentCharIndex + 1],
        CharState.untyped,
      );

      expect(thirdTest.currentWordIndex, 0);
    });
  });
}
