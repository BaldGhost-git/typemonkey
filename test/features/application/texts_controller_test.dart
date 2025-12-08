import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:typingapp/features/typing/application/texts_controller.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
import 'package:typingapp/features/typing/domain/word.dart';

void main() {
  group('TypingTrainerStateViewModel', () {
    test('has expected initial state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(typingTrainerStateViewModelProvider);

      expect(state.isRunning, false);
      expect(state.isFinished, false);
      expect(state.testDuration, isNonNegative);
      expect(state.textLength, isNonNegative);
      expect(state.type, TestType.time);
    });

    test('startTest in time mode sets running and elapsedTime', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(
        typingTrainerStateViewModelProvider.notifier,
      );

      notifier.startTest();

      final state = container.read(typingTrainerStateViewModelProvider);

      expect(state.isRunning, true);
      expect(state.isFinished, false);
      expect(state.elapsedTime, state.testDuration);
    });

    test('setTypeTest and setTypeConfig update word configuration', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(
        typingTrainerStateViewModelProvider.notifier,
      );

      notifier.setTypeTest(TestType.word);
      notifier.setTypeConfig(10);

      final state = container.read(typingTrainerStateViewModelProvider);

      expect(state.type, TestType.word);
      expect(state.textLength, 10);
      expect(state.testDuration, TimeConfig.twenty.duration);
    });

    test(
      'onTextProgress stops word test when configured word is completed',
      () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // Keep the autoDispose provider alive for the duration of this test.
        final sub = container.listen(
          typingTrainerStateViewModelProvider,
          (_, __) {},
        );
        addTearDown(sub.close);

        final notifier = container.read(
          typingTrainerStateViewModelProvider.notifier,
        );

        notifier.setTypeTest(TestType.word);
        notifier.setTypeConfig(1); // single-word test

        notifier.startTest();

        final text = TextTyping.fromString('Hi');
        final completed = text.typed('H').typed('i');

        // Ensure a non-zero elapsed time in seconds.
        await Future<void>.delayed(const Duration(milliseconds: 1100));

        notifier.onTextProgress(completed);

        final state = container.read(typingTrainerStateViewModelProvider);

        expect(state.isFinished, true);
        expect(state.isRunning, false);
        expect(state.accuracy, 100);
        expect(state.wpm, greaterThan(0));
      },
    );
  });

  group('TypingTrainerViewModel', () {
    test('typed starts test and updates current word state', () async {
      final container = ProviderContainer(
        overrides: [
          getTextProvider.overrideWith(
            (ref, cfg) => TextTyping.fromString('Hi'),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(typingTrainerViewModelProvider.future);

      final vm = container.read(typingTrainerViewModelProvider.notifier);

      vm.typed('H');

      final textState = container.read(typingTrainerViewModelProvider);
      final trainerState = container.read(typingTrainerStateViewModelProvider);

      expect(trainerState.isRunning, true);
      expect(textState.hasValue, true);
      expect(textState.value!.currentWord.charState.first, CharState.correct);
    });

    test('spacePressed moves to next word', () async {
      final container = ProviderContainer(
        overrides: [
          getTextProvider.overrideWith(
            (ref, cfg) => TextTyping.fromString('Hi there'),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(typingTrainerViewModelProvider.future);

      final vm = container.read(typingTrainerViewModelProvider.notifier);

      vm.typed('H');
      vm.typed('i');
      vm.spacePressed();

      final textState = container.read(typingTrainerViewModelProvider).value!;

      expect(textState.currentWordIndex, 1);
    });

    test('backspacePressed deletes previous character', () async {
      final container = ProviderContainer(
        overrides: [
          getTextProvider.overrideWith(
            (ref, cfg) => TextTyping.fromString('Hi'),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(typingTrainerViewModelProvider.future);

      final vm = container.read(typingTrainerViewModelProvider.notifier);

      vm.typed('H');
      vm.backspacePressed();

      final textState = container.read(typingTrainerViewModelProvider).value!;

      expect(textState.currentWord.charState.first, CharState.untyped);
    });

    test(
      'word test finishes when configured word is completed via typed',
      () async {
        final container = ProviderContainer(
          overrides: [
            getTextProvider.overrideWith(
              (ref, cfg) => TextTyping.fromString('Hi'),
            ),
          ],
        );
        addTearDown(container.dispose);

        await container.read(typingTrainerViewModelProvider.future);

        final trainerVm = container.read(
          typingTrainerStateViewModelProvider.notifier,
        );

        trainerVm.setTypeTest(TestType.word);
        trainerVm.setTypeConfig(1);

        final vm = container.read(typingTrainerViewModelProvider.notifier);

        vm.typed('H');
        vm.typed('i');

        final trainerState = container.read(
          typingTrainerStateViewModelProvider,
        );

        expect(trainerState.isFinished, true);
        expect(trainerState.isRunning, false);
        expect(trainerState.accuracy, 100);
      },
    );
  });
}
