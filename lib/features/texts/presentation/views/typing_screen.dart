import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/texts/domain/text.dart';
import 'package:typingapp/features/texts/presentation/viewmodel/texts_controller.dart';
import 'package:gap/gap.dart';

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
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(typingTrainerViewModelProvider.notifier);
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
                    // RichText(
                    //   maxLines: 3,
                    //   overflow: TextOverflow.clip,
                    //   text: TextSpan(
                    //     style: GoogleFonts.jetBrainsMono(fontSize: 30),
                    //     children: state.currentText.words.map((word) {
                    //       final color = switch (word.currentCharState) {
                    //         CharState.untyped => Colors.black45,
                    //         CharState.correct => Colors.yellow,
                    //         CharState.incorrect => Colors.red,
                    //       };
                    //       return TextSpan(
                    //         text: '${word.word} ',
                    //         style: TextStyle(color: color),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    Shortcuts(
                      shortcuts: const <ShortcutActivator, Intent>{
                        SingleActivator(LogicalKeyboardKey.backspace):
                            BackspaceIntent(),
                        SingleActivator(LogicalKeyboardKey.space):
                            NextWordIntent(),
                      },
                      child: Actions(
                        actions: <Type, Action<Intent>>{
                          BackspaceIntent: CallbackAction<BackspaceIntent>(
                            onInvoke: (intent) => null,
                          ),
                          NextWordIntent: CallbackAction<NextWordIntent>(
                            onInvoke: (intent) => vm.spacePressed(),
                          ),
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
                          cursorColor: Colors.red,
                          backgroundCursorColor: Colors.orange,
                          onChanged: (value) {
                            vm.typedOnChanged(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              error: (error, stackTrace) => Text('data'),
              loading: () => CircularProgressIndicator.adaptive(),
            ),
            // Gap(20),
            // TextField(
            //   style: GoogleFonts.jetBrainsMono(fontSize: 30),
            //   decoration: InputDecoration(border: OutlineInputBorder()),
            // ),
          ],
        ),
      ),
    );
  }
}

class NextWordIntent extends Intent {
  const NextWordIntent();
}

class BackspaceIntent extends Intent {
  const BackspaceIntent();
}
