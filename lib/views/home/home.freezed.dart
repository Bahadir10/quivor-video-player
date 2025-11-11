// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeScreenState {
  List<VideoEntity>? get recents => throw _privateConstructorUsedError;
  List<PlaylistStateResponseModel>? get playlists =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeScreenStateCopyWith<HomeScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenStateCopyWith<$Res> {
  factory $HomeScreenStateCopyWith(
          HomeScreenState value, $Res Function(HomeScreenState) then) =
      _$HomeScreenStateCopyWithImpl<$Res, HomeScreenState>;
  @useResult
  $Res call(
      {List<VideoEntity>? recents,
      List<PlaylistStateResponseModel>? playlists,
      bool isLoading});
}

/// @nodoc
class _$HomeScreenStateCopyWithImpl<$Res, $Val extends HomeScreenState>
    implements $HomeScreenStateCopyWith<$Res> {
  _$HomeScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recents = freezed,
    Object? playlists = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      recents: freezed == recents
          ? _value.recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<VideoEntity>?,
      playlists: freezed == playlists
          ? _value.playlists
          : playlists // ignore: cast_nullable_to_non_nullable
              as List<PlaylistStateResponseModel>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$HomeScreenStateImplImplCopyWith<$Res>
    implements $HomeScreenStateCopyWith<$Res> {
  factory _$$$HomeScreenStateImplImplCopyWith(_$$HomeScreenStateImplImpl value,
          $Res Function(_$$HomeScreenStateImplImpl) then) =
      __$$$HomeScreenStateImplImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<VideoEntity>? recents,
      List<PlaylistStateResponseModel>? playlists,
      bool isLoading});
}

/// @nodoc
class __$$$HomeScreenStateImplImplCopyWithImpl<$Res>
    extends _$HomeScreenStateCopyWithImpl<$Res, _$$HomeScreenStateImplImpl>
    implements _$$$HomeScreenStateImplImplCopyWith<$Res> {
  __$$$HomeScreenStateImplImplCopyWithImpl(_$$HomeScreenStateImplImpl _value,
      $Res Function(_$$HomeScreenStateImplImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recents = freezed,
    Object? playlists = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$$HomeScreenStateImplImpl(
      recents: freezed == recents
          ? _value._recents
          : recents // ignore: cast_nullable_to_non_nullable
              as List<VideoEntity>?,
      playlists: freezed == playlists
          ? _value._playlists
          : playlists // ignore: cast_nullable_to_non_nullable
              as List<PlaylistStateResponseModel>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$$HomeScreenStateImplImpl implements _$HomeScreenStateImpl {
  _$$HomeScreenStateImplImpl(
      {final List<VideoEntity>? recents,
      final List<PlaylistStateResponseModel>? playlists,
      this.isLoading = true})
      : _recents = recents,
        _playlists = playlists;

  final List<VideoEntity>? _recents;
  @override
  List<VideoEntity>? get recents {
    final value = _recents;
    if (value == null) return null;
    if (_recents is EqualUnmodifiableListView) return _recents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PlaylistStateResponseModel>? _playlists;
  @override
  List<PlaylistStateResponseModel>? get playlists {
    final value = _playlists;
    if (value == null) return null;
    if (_playlists is EqualUnmodifiableListView) return _playlists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'HomeScreenState(recents: $recents, playlists: $playlists, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$HomeScreenStateImplImpl &&
            const DeepCollectionEquality().equals(other._recents, _recents) &&
            const DeepCollectionEquality()
                .equals(other._playlists, _playlists) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recents),
      const DeepCollectionEquality().hash(_playlists),
      isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$HomeScreenStateImplImplCopyWith<_$$HomeScreenStateImplImpl>
      get copyWith =>
          __$$$HomeScreenStateImplImplCopyWithImpl<_$$HomeScreenStateImplImpl>(
              this, _$identity);
}

abstract class _$HomeScreenStateImpl implements HomeScreenState {
  factory _$HomeScreenStateImpl(
      {final List<VideoEntity>? recents,
      final List<PlaylistStateResponseModel>? playlists,
      final bool isLoading}) = _$$HomeScreenStateImplImpl;

  @override
  List<VideoEntity>? get recents;
  @override
  List<PlaylistStateResponseModel>? get playlists;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$$HomeScreenStateImplImplCopyWith<_$$HomeScreenStateImplImpl>
      get copyWith => throw _privateConstructorUsedError;
}
