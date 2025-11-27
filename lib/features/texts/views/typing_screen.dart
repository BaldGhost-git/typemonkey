import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typingapp/features/texts/controllers/texts_controller.dart';
import 'package:gap/gap.dart';

class TypingScreen extends StatelessWidget {
  const TypingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          width: 1200,
          child: Column(
            children: [
              Consumer(
                builder: (widget, ref, child) {
                  final data = ref.watch(getTextProvider);
                  return data.when(
                    data: (text) => RichText(
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        children: text.words
                            .map((word) => TextSpan(text: '${word.word} '))
                            .toList(),
                      ),
                    ),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => CircularProgressIndicator.adaptive(),
                  );
                },
              ),
              Gap(20),
              TextField(
                style: GoogleFonts.jetBrainsMono(fontSize: 30),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
