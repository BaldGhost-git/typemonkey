import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_config.g.dart';

@Riverpod(keepAlive: true)
Dio dioConfig(Ref ref, String url) {
  final dio = Dio(
    BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  );

  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  return dio;
}
