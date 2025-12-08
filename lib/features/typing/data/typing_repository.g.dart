// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(typingRepository)
const typingRepositoryProvider = TypingRepositoryFamily._();

final class TypingRepositoryProvider
    extends
        $FunctionalProvider<
          TypingRepository,
          TypingRepository,
          TypingRepository
        >
    with $Provider<TypingRepository> {
  const TypingRepositoryProvider._({
    required TypingRepositoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'typingRepositoryProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$typingRepositoryHash();

  @override
  String toString() {
    return r'typingRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<TypingRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TypingRepository create(Ref ref) {
    final argument = this.argument as String;
    return typingRepository(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TypingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TypingRepository>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TypingRepositoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$typingRepositoryHash() => r'5bda308685484eefc12194ede0d6fc7dfd603dec';

final class TypingRepositoryFamily extends $Family
    with $FunctionalFamilyOverride<TypingRepository, String> {
  const TypingRepositoryFamily._()
    : super(
        retry: null,
        name: r'typingRepositoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  TypingRepositoryProvider call(String url) =>
      TypingRepositoryProvider._(argument: url, from: this);

  @override
  String toString() => r'typingRepositoryProvider';
}
