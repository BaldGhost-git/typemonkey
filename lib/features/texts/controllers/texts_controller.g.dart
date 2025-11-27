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
    extends $FunctionalProvider<AsyncValue<Text>, Text, FutureOr<Text>>
    with $FutureModifier<Text>, $FutureProvider<Text> {
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
  $FutureProviderElement<Text> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Text> create(Ref ref) {
    return getText(ref);
  }
}

String _$getTextHash() => r'7397975a17478769bdc6512089ea103258625ab4';
