import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', requireEnvFile: true)
abstract class Env {
  @EnviedField(varName: 'WORD_API')
  static const String wordApi = _Env.wordApi;

  @EnviedField(varName: 'ENV', defaultValue: 'development', optional: true)
  static const String env = _Env.env;
}
