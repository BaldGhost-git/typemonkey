// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getText)
const getTextProvider = GetTextProvider._();

final class GetTextProvider
    extends
        $FunctionalProvider<
          AsyncValue<TextTyping>,
          TextTyping,
          FutureOr<TextTyping>
        >
    with $FutureModifier<TextTyping>, $FutureProvider<TextTyping> {
  const GetTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTextHash();

  @$internal
  @override
  $FutureProviderElement<TextTyping> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TextTyping> create(Ref ref) {
    return getText(ref);
  }
}

String _$getTextHash() => r'01ee57613703f7b653e19a121e800161efeaee01';

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
    r'fe023054ebbd45bb60d072cdb6efa89475d873c9';

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
    r'93282a6397a56f54b63bd277390acd7aba9b76f4';

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
