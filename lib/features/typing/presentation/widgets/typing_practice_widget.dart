import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:typingapp/core/themes/sizes.dart';
import 'package:typingapp/core/themes/styles.dart';
import 'package:typingapp/core/themes/themes.dart';
import 'package:typingapp/features/typing/application/typing_text_viewmodel.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';
import 'package:typingapp/features/typing/domain/word.dart';
import 'package:typingapp/features/typing/presentation/widgets/custom_caret.dart';

class TypingPractice extends StatefulWidget {
  final TextTyping textState;
  final TypingTrainerState trainerState;
  final TypingTextViewModel viewModel;
  const TypingPractice({
    super.key,
    required this.textState,
    required this.viewModel,
    required this.trainerState,
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
      height: AppSizes.typingTextViewportHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: RichText(
              text: buildText(widget.textState, widget.trainerState),
            ),
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
              style: AppStyles.primaryFont.copyWith(
                color: Colors.transparent,
                fontSize: AppSizes.heading2,
              ),
              cursorColor: Colors.transparent,
              backgroundCursorColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  TextSpan buildText(TextTyping state, TypingTrainerState trainerState) {
    final shownWords = trainerState.type == TestType.word
        ? state.words.take(trainerState.textLength!)
        : state.words;
    return TextSpan(
      style: AppStyles.primaryHeading2,
      children: shownWords.indexed.map((element) {
        final (index, word) = element;
        final isUnderline =
            (state.currentWordIndex > index) &&
            (!word.isWordCorrect || !word.isWordDone);
        return TextSpan(
          style: TextStyle(
            decoration: isUnderline ? TextDecoration.underline : null,
            decorationColor: AppThemes.colorScheme.error,
          ),
          children: word.word.split('').indexed.map((charState) {
            final charPointer = charState.$1;
            final stateLength = word.charState.length - 1;
            final color = switch (word.charState[charPointer]) {
              CharState.untyped => AppThemes.colorScheme.primary.withAlpha(120),
              CharState.correct => AppThemes.colorScheme.tertiary,
              CharState.incorrect => AppThemes.colorScheme.error,
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
