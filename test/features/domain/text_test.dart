import 'package:flutter_test/flutter_test.dart';
import 'package:typingapp/features/texts/domain/text.dart';

void main() {
  group('Test Text class functions', () {
    final String str = 'He is him';

    test('Current word completed, then try to go to next word', () {
      // Arrange
      final text = TextTyping.fromString(str);

      //Act
      final newText = text.typed('H').typed('e').nextWord();

      //Assert
      expect(newText.wordsIncompleteness[newText.currentWordIndex - 1], false);
    });

    test(
      'Current word not completed/incorrect, then try to go to next word',
      () {
        //Arrange
        final text = TextTyping.fromString(str);

        //Act
        final newText = text.typed('H').nextWord();

        //Assert
        expect(newText.wordsIncompleteness[newText.currentWordIndex - 1], true);
      },
    );

    test(
      'User try to backtrack to a completed & correct word should be denied',
      () {
        //Arrange
        final text = TextTyping.fromString(str);

        //Act
        final newText = text.typed('H').typed('e').nextWord().previousWord();

        //Assert
        expect(newText.currentWordIndex, 1);
      },
    );

    test(
      'User try to backtrack to an incorrect or incomplete word should be allowed',
      () {
        //Arrange
        final text = TextTyping.fromString(str);

        //Act
        final newText = text.typed('H').typed('r').nextWord().previousWord();

        //Assert
        expect(newText.currentWordIndex, 0);
      },
    );
  });
}
