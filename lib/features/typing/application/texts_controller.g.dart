// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getText)
const getTextProvider = GetTextFamily._();

final class GetTextProvider
    extends
        $FunctionalProvider<
          AsyncValue<TextTyping>,
          TextTyping,
          FutureOr<TextTyping>
        >
    with $FutureModifier<TextTyping>, $FutureProvider<TextTyping> {
  const GetTextProvider._({
    required GetTextFamily super.from,
    required LanguageConfig super.argument,
  }) : super(
         retry: null,
         name: r'getTextProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getTextHash();

  @override
  String toString() {
    return r'getTextProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TextTyping> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TextTyping> create(Ref ref) {
    final argument = this.argument as LanguageConfig;
    return getText(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTextProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getTextHash() => r'3746beb4372fa9d8ef16e31ddfd4590366a208dc';

final class GetTextFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TextTyping>, LanguageConfig> {
  const GetTextFamily._()
    : super(
        retry: null,
        name: r'getTextProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  GetTextProvider call(LanguageConfig language) =>
      GetTextProvider._(argument: language, from: this);

  @override
  String toString() => r'getTextProvider';
}

@ProviderFor(LanguageConfigViewModel)
const languageConfigViewModelProvider = LanguageConfigViewModelProvider._();

final class LanguageConfigViewModelProvider
    extends $NotifierProvider<LanguageConfigViewModel, LanguageConfig> {
  const LanguageConfigViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageConfigViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageConfigViewModelHash();

  @$internal
  @override
  LanguageConfigViewModel create() => LanguageConfigViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LanguageConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LanguageConfig>(value),
    );
  }
}

String _$languageConfigViewModelHash() =>
    r'2a1eff7f31b2fa853e40159082832c5d4125e003';

abstract class _$LanguageConfigViewModel extends $Notifier<LanguageConfig> {
  LanguageConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LanguageConfig, LanguageConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LanguageConfig, LanguageConfig>,
              LanguageConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TypingTrainerStateViewModel)
const typingTrainerStateViewModelProvider =
    TypingTrainerStateViewModelProvider._();

final class TypingTrainerStateViewModelProvider
    extends $NotifierProvider<TypingTrainerStateViewModel, TypingTrainerState> {
  const TypingTrainerStateViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'typingTrainerStateViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$typingTrainerStateViewModelHash();

  @$internal
  @override
  TypingTrainerStateViewModel create() => TypingTrainerStateViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TypingTrainerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TypingTrainerState>(value),
    );
  }
}

String _$typingTrainerStateViewModelHash() =>
    r'4ba3be9da178252d4ee8c1c7fb40155dbed4ac4f';

abstract class _$TypingTrainerStateViewModel
    extends $Notifier<TypingTrainerState> {
  TypingTrainerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TypingTrainerState, TypingTrainerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TypingTrainerState, TypingTrainerState>,
              TypingTrainerState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TypingTrainerViewModel)
const typingTrainerViewModelProvider = TypingTrainerViewModelProvider._();

final class TypingTrainerViewModelProvider
    extends $AsyncNotifierProvider<TypingTrainerViewModel, TextTyping> {
  const TypingTrainerViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'typingTrainerViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$typingTrainerViewModelHash();

  @$internal
  @override
  TypingTrainerViewModel create() => TypingTrainerViewModel();
}

String _$typingTrainerViewModelHash() =>
    r'acf0864913cbaaf40ae60d267e0e96fadb258b02';

abstract class _$TypingTrainerViewModel extends $AsyncNotifier<TextTyping> {
  FutureOr<TextTyping> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TextTyping>, TextTyping>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TextTyping>, TextTyping>,
              AsyncValue<TextTyping>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
