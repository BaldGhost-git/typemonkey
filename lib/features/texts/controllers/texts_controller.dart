import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/texts/domain/word_text.dart';

part 'texts_controller.g.dart';

@riverpod
Future<Text> getText(Ref ref) async {
  final string = await File('assets/strings/lipsum.txt').readAsString();
  return Text.fromString(string);
}
