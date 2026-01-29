// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_prefences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserPrefrences {
  double get volume => throw _privateConstructorUsedError;
  AutoPlayMode get autoPlayMode => throw _privateConstructorUsedError;
  int get earlyTransitionSeconds => throw _privateConstructorUsedError;
  int get seekDurationSeconds => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserPrefrencesCopyWith<UserPrefrences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPrefrencesCopyWith<$Res> {
  factory $UserPrefrencesCopyWith(
          UserPrefrences value, $Res Function(UserPrefrences) then) =
      _$UserPrefrencesCopyWithImpl<$Res, UserPrefrences>;
  @useResult
  $Res call(
      {double volume,
      AutoPlayMode autoPlayMode,
      int earlyTransitionSeconds,
      int seekDurationSeconds});
}

/// @nodoc
class _$UserPrefrencesCopyWithImpl<$Res, $Val extends UserPrefrences>
    implements $UserPrefrencesCopyWith<$Res> {
  _$UserPrefrencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? volume = null,
    Object? autoPlayMode = null,
    Object? earlyTransitionSeconds = null,
    Object? seekDurationSeconds = null,
  }) {
    return _then(_value.copyWith(
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      autoPlayMode: null == autoPlayMode
          ? _value.autoPlayMode
          : autoPlayMode // ignore: cast_nullable_to_non_nullable
              as AutoPlayMode,
      earlyTransitionSeconds: null == earlyTransitionSeconds
          ? _value.earlyTransitionSeconds
          : earlyTransitionSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      seekDurationSeconds: null == seekDurationSeconds
          ? _value.seekDurationSeconds
          : seekDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPrefrencesImplCopyWith<$Res>
    implements $UserPrefrencesCopyWith<$Res> {
  factory _$$UserPrefrencesImplCopyWith(_$UserPrefrencesImpl value,
          $Res Function(_$UserPrefrencesImpl) then) =
      __$$UserPrefrencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double volume,
      AutoPlayMode autoPlayMode,
      int earlyTransitionSeconds,
      int seekDurationSeconds});
}

/// @nodoc
class __$$UserPrefrencesImplCopyWithImpl<$Res>
    extends _$UserPrefrencesCopyWithImpl<$Res, _$UserPrefrencesImpl>
    implements _$$UserPrefrencesImplCopyWith<$Res> {
  __$$UserPrefrencesImplCopyWithImpl(
      _$UserPrefrencesImpl _value, $Res Function(_$UserPrefrencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? volume = null,
    Object? autoPlayMode = null,
    Object? earlyTransitionSeconds = null,
    Object? seekDurationSeconds = null,
  }) {
    return _then(_$UserPrefrencesImpl(
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      autoPlayMode: null == autoPlayMode
          ? _value.autoPlayMode
          : autoPlayMode // ignore: cast_nullable_to_non_nullable
              as AutoPlayMode,
      earlyTransitionSeconds: null == earlyTransitionSeconds
          ? _value.earlyTransitionSeconds
          : earlyTransitionSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      seekDurationSeconds: null == seekDurationSeconds
          ? _value.seekDurationSeconds
          : seekDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserPrefrencesImpl implements _UserPrefrences {
  _$UserPrefrencesImpl(
      {required this.volume,
      this.autoPlayMode = AutoPlayMode.early,
      this.earlyTransitionSeconds = 15,
      this.seekDurationSeconds = 10});

  @override
  final double volume;
  @override
  @JsonKey()
  final AutoPlayMode autoPlayMode;
  @override
  @JsonKey()
  final int earlyTransitionSeconds;
  @override
  @JsonKey()
  final int seekDurationSeconds;

  @override
  String toString() {
    return 'UserPrefrences(volume: $volume, autoPlayMode: $autoPlayMode, earlyTransitionSeconds: $earlyTransitionSeconds, seekDurationSeconds: $seekDurationSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPrefrencesImpl &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.autoPlayMode, autoPlayMode) ||
                other.autoPlayMode == autoPlayMode) &&
            (identical(other.earlyTransitionSeconds, earlyTransitionSeconds) ||
                other.earlyTransitionSeconds == earlyTransitionSeconds) &&
            (identical(other.seekDurationSeconds, seekDurationSeconds) ||
                other.seekDurationSeconds == seekDurationSeconds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, volume, autoPlayMode,
      earlyTransitionSeconds, seekDurationSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPrefrencesImplCopyWith<_$UserPrefrencesImpl> get copyWith =>
      __$$UserPrefrencesImplCopyWithImpl<_$UserPrefrencesImpl>(
          this, _$identity);
}

abstract class _UserPrefrences implements UserPrefrences {
  factory _UserPrefrences(
      {required final double volume,
      final AutoPlayMode autoPlayMode,
      final int earlyTransitionSeconds,
      final int seekDurationSeconds}) = _$UserPrefrencesImpl;

  @override
  double get volume;
  @override
  AutoPlayMode get autoPlayMode;
  @override
  int get earlyTransitionSeconds;
  @override
  int get seekDurationSeconds;
  @override
  @JsonKey(ignore: true)
  _$$UserPrefrencesImplCopyWith<_$UserPrefrencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
