// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typing_practice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TypingTrainerState {

 int? get testDuration; int? get textLength; double get wpm; double get accuracy; int? get elapsedTime; bool get isRunning; bool get isFinished;
/// Create a copy of TypingTrainerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingTrainerStateCopyWith<TypingTrainerState> get copyWith => _$TypingTrainerStateCopyWithImpl<TypingTrainerState>(this as TypingTrainerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingTrainerState&&(identical(other.testDuration, testDuration) || other.testDuration == testDuration)&&(identical(other.textLength, textLength) || other.textLength == textLength)&&(identical(other.wpm, wpm) || other.wpm == wpm)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.elapsedTime, elapsedTime) || other.elapsedTime == elapsedTime)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.isFinished, isFinished) || other.isFinished == isFinished));
}


@override
int get hashCode => Object.hash(runtimeType,testDuration,textLength,wpm,accuracy,elapsedTime,isRunning,isFinished);

@override
String toString() {
  return 'TypingTrainerState(testDuration: $testDuration, textLength: $textLength, wpm: $wpm, accuracy: $accuracy, elapsedTime: $elapsedTime, isRunning: $isRunning, isFinished: $isFinished)';
}


}

/// @nodoc
abstract mixin class $TypingTrainerStateCopyWith<$Res>  {
  factory $TypingTrainerStateCopyWith(TypingTrainerState value, $Res Function(TypingTrainerState) _then) = _$TypingTrainerStateCopyWithImpl;
@useResult
$Res call({
 int? testDuration, int? textLength, double wpm, double accuracy, int? elapsedTime, bool isRunning, bool isFinished
});




}
/// @nodoc
class _$TypingTrainerStateCopyWithImpl<$Res>
    implements $TypingTrainerStateCopyWith<$Res> {
  _$TypingTrainerStateCopyWithImpl(this._self, this._then);

  final TypingTrainerState _self;
  final $Res Function(TypingTrainerState) _then;

/// Create a copy of TypingTrainerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? testDuration = freezed,Object? textLength = freezed,Object? wpm = null,Object? accuracy = null,Object? elapsedTime = freezed,Object? isRunning = null,Object? isFinished = null,}) {
  return _then(TypingTrainerState(
testDuration: freezed == testDuration ? _self.testDuration : testDuration // ignore: cast_nullable_to_non_nullable
as int?,textLength: freezed == textLength ? _self.textLength : textLength // ignore: cast_nullable_to_non_nullable
as int?,wpm: null == wpm ? _self.wpm : wpm // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,elapsedTime: freezed == elapsedTime ? _self.elapsedTime : elapsedTime // ignore: cast_nullable_to_non_nullable
as int?,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isFinished: null == isFinished ? _self.isFinished : isFinished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TypingTrainerState].
extension TypingTrainerStatePatterns on TypingTrainerState {
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
