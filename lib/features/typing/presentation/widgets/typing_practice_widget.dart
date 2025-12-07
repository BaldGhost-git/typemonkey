import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/typing/application/texts_controller.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/features/typing/domain/word.dart';
import 'package:typingapp/features/typing/presentation/widgets/custom_caret.dart';

class TypingPractice extends StatefulWidget {
  final TextTyping state;
  final TypingTrainerViewModel viewModel;
  const TypingPractice({
    required this.state,
    required this.viewModel,
    super.key,
  });

  @override
  State<TypingPractice> createState() => _TypingPracticeState();
}

class _TypingPracticeState extends State<TypingPractice> {
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
    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RichText(
            maxLines: 3,
            overflow: TextOverflow.clip,
            text: buildText(widget.state),
          ),
          Focus(
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent) {
                if (event.logicalKey == LogicalKeyboardKey.space) {
                  widget.viewModel.spacePressed();
                } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
                  widget.viewModel.backspacePressed();
                } else {
                  final ch = event.character;
                  if (ch != null && ch.length == 1) {
                    widget.viewModel.typed(ch);
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
          children: word.word.split('').indexed.map((charState) {
            final charPointer = charState.$1;
            final stateLength = word.charState.length - 1;
            final color = switch (word.charState[charPointer]) {
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
                    child: CustomCaret(),
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
