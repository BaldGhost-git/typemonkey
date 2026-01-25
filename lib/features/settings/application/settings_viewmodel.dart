import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typemonkey/features/settings/domain/settings.dart';

part 'settings_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class SettingsViewModel extends _$SettingsViewModel {
  @override
  Settings build() {
    return Settings(isDarkMode: true);
  }

  void flipScheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}
