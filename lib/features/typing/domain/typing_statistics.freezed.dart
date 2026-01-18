// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typing_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TypingStatistics {

 int get correctChars; int get incorrectChars; double get elapsedTimeInSeconds; DateTime? get timestamp;
/// Create a copy of TypingStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingStatisticsCopyWith<TypingStatistics> get copyWith => _$TypingStatisticsCopyWithImpl<TypingStatistics>(this as TypingStatistics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingStatistics&&(identical(other.correctChars, correctChars) || other.correctChars == correctChars)&&(identical(other.incorrectChars, incorrectChars) || other.incorrectChars == incorrectChars)&&(identical(other.elapsedTimeInSeconds, elapsedTimeInSeconds) || other.elapsedTimeInSeconds == elapsedTimeInSeconds)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,correctChars,incorrectChars,elapsedTimeInSeconds,timestamp);

@override
String toString() {
  return 'TypingStatistics(correctChars: $correctChars, incorrectChars: $incorrectChars, elapsedTimeInSeconds: $elapsedTimeInSeconds, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $TypingStatisticsCopyWith<$Res>  {
  factory $TypingStatisticsCopyWith(TypingStatistics value, $Res Function(TypingStatistics) _then) = _$TypingStatisticsCopyWithImpl;
@useResult
$Res call({
 int correctChars, int incorrectChars, double elapsedTimeInSeconds, DateTime? timestamp
});




}
/// @nodoc
class _$TypingStatisticsCopyWithImpl<$Res>
    implements $TypingStatisticsCopyWith<$Res> {
  _$TypingStatisticsCopyWithImpl(this._self, this._then);

  final TypingStatistics _self;
  final $Res Function(TypingStatistics) _then;

/// Create a copy of TypingStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? correctChars = null,Object? incorrectChars = null,Object? elapsedTimeInSeconds = null,Object? timestamp = freezed,}) {
  return _then(TypingStatistics(
correctChars: null == correctChars ? _self.correctChars : correctChars // ignore: cast_nullable_to_non_nullable
as int,incorrectChars: null == incorrectChars ? _self.incorrectChars : incorrectChars // ignore: cast_nullable_to_non_nullable
as int,elapsedTimeInSeconds: null == elapsedTimeInSeconds ? _self.elapsedTimeInSeconds : elapsedTimeInSeconds // ignore: cast_nullable_to_non_nullable
as double,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TypingStatistics].
extension TypingStatisticsPatterns on TypingStatistics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
