// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dioConfig)
const dioConfigProvider = DioConfigFamily._();

final class DioConfigProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioConfigProvider._({
    required DioConfigFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dioConfigProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dioConfigHash();

  @override
  String toString() {
    return r'dioConfigProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    final argument = this.argument as String;
    return dioConfig(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DioConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dioConfigHash() => r'bdcb43df1e713b1df6d621f5eb59fa92dd707225';

final class DioConfigFamily extends $Family
    with $FunctionalFamilyOverride<Dio, String> {
  const DioConfigFamily._()
    : super(
        retry: null,
        name: r'dioConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  DioConfigProvider call(String url) =>
      DioConfigProvider._(argument: url, from: this);

  @override
  String toString() => r'dioConfigProvider';
}
