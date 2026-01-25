import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/typing/data/text_dto.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/core/config/dio_config.dart';
import 'package:typingapp/features/typing/domain/typing_practice.dart';

part 'typing_repository.g.dart';

@Riverpod(keepAlive: true)
TypingRepository typingRepository(Ref ref, String url) {
  final dio = ref.read(dioConfigProvider(url));
  return TypingRepository(dio: dio);
}

class TypingRepository {
  final Dio dio;

  TypingRepository({required this.dio});

  Future<TextTyping> getNewText({String? languages}) async {
    try {
      final response = await dio.get('/languages/${languages ?? 'english'}');
      final dtoData = TextDto.fromJson(response.data as Map<String, dynamic>);
      final data = dtoData.toEntity();
      return data;
    } on DioException catch (_) {
      final string = await File('assets/strings/lipsum.txt').readAsString();
      return TextTyping.fromString(string);
    }
  }

  Future<LanguageConfig> getLanguageOptions() async {
    try {
      final response = await dio.get('/languages');
      final data = response.data as Map<String, dynamic>;
      final opts = (data['option'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
      return LanguageConfig(options: opts, current: opts[0]);
    } on DioException catch (_) {
      return LanguageConfig(options: ['english'], current: 'english');
    }
  }
}
