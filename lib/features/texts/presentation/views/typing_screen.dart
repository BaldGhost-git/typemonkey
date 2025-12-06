import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/texts/domain/text.dart';
import 'package:typingapp/features/texts/domain/word.dart';
import 'package:typingapp/features/texts/presentation/viewmodel/texts_controller.dart';

class TypingScreen extends ConsumerStatefulWidget {
  const TypingScreen({super.key});

  @override
  ConsumerState<TypingScreen> createState() => _TypingScreenState();
}

class _TypingScreenState extends ConsumerState<TypingScreen> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(typingTrainerViewModelProvider.notifier);
    final typingState = ref.watch(typingTrainerViewModelProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            typingState.when(
              data: (state) => SizedBox(
                height: 300,
                width: 1200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    RichText(
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      text: buildText(state),
                    ),
                    Focus(
                      onKeyEvent: (node, event) {
                        if (event is KeyDownEvent) {
                          if (event.logicalKey == LogicalKeyboardKey.space) {
                            vm.spacePressed();
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.backspace) {
                            vm.backspacePressed();
                          } else {
                            final ch = event.character;
                            if (ch != null && ch.length == 1) {
                              vm.typed(ch);
                            }
                          }
                        }
                        return KeyEventResult.ignored;
                      },
                      child: EditableText(
                        maxLines: 3,
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: true,
                        style: GoogleFonts.jetBrainsMono(
                          color: Colors.transparent,
                          fontSize: 30,
                        ),
                        cursorColor: Colors.transparent,
                        backgroundCursorColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => CircularProgressIndicator.adaptive(),
            ),
            Gap(20),
            Text(_controller.text, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  TextSpan buildText(TextTyping state) {
    return TextSpan(
      style: GoogleFonts.jetBrainsMono(fontSize: 30),
      children: state.words.indexed.map((element) {
        final (index, word) = element;
        final isUnderline =
            (state.currentWordIndex > index) &&
            (!word.isWordCorrect || !word.isWordDone);
        return TextSpan(
          style: TextStyle(
            color: Colors.amber,
            decoration: isUnderline ? TextDecoration.underline : null,
          ),
          children: word.charState.indexed.map((charState) {
            final charPointer = charState.$1;
            final stateLength = word.charState.length - 1;
            final color = switch (charState.$2) {
              CharState.untyped => Colors.white30,
              CharState.correct => Colors.green,
              CharState.incorrect => Colors.red,
            };
            return TextSpan(
              children: [
                if (state.currentWordIndex == index &&
                    charPointer == word.currentCharIndex + 1)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: Container(height: 30, width: 10, color: Colors.red),
                  ),
                TextSpan(
                  text: charPointer < stateLength
                      ? word.word[charPointer]
                      : '${word.word[charPointer]} ',
                ),
              ],
              style: TextStyle(color: color),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class NextWordIntent extends Intent {
  const NextWordIntent();
}

class BackspaceIntent extends Intent {
  const BackspaceIntent();
}
