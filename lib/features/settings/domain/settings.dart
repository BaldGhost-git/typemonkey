import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  @override
  final bool isDarkMode;

  Settings({required this.isDarkMode});
}
