import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typingapp/features/typing/data/text_dto.dart';
import 'package:typingapp/features/typing/domain/text.dart';
import 'package:typingapp/services/dio_config.dart';

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
      final response = await dio.get(
        '/languages/${languages ?? 'english'}.json',
      );
      final dtoData = TextDto.fromJson(response.data as Map<String, dynamic>);
      final data = dtoData.toEntity();
      return data;
    } on DioException {
      rethrow;
    }
  }
}
