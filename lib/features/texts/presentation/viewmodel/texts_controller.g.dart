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
    r'14dddda88a1abe03ff3da2524babbdd9de056498';

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
