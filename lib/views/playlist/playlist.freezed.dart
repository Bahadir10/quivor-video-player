// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlaylistScreenState {
  List<VideoEntity>? get videos => throw _privateConstructorUsedError;
  PlaylistStateResponseModel get playlist => throw _privateConstructorUsedError;
  bool get isSideBarOpen => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaylistScreenStateCopyWith<PlaylistScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistScreenStateCopyWith<$Res> {
  factory $PlaylistScreenStateCopyWith(
          PlaylistScreenState value, $Res Function(PlaylistScreenState) then) =
      _$PlaylistScreenStateCopyWithImpl<$Res, PlaylistScreenState>;
  @useResult
  $Res call(
      {List<VideoEntity>? videos,
      PlaylistStateResponseModel playlist,
      bool isSideBarOpen,
      bool isLoading});
}

/// @nodoc
class _$PlaylistScreenStateCopyWithImpl<$Res, $Val extends PlaylistScreenState>
    implements $PlaylistScreenStateCopyWith<$Res> {
  _$PlaylistScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = freezed,
    Object? playlist = null,
    Object? isSideBarOpen = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      videos: freezed == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<VideoEntity>?,
      playlist: null == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as PlaylistStateResponseModel,
      isSideBarOpen: null == isSideBarOpen
          ? _value.isSideBarOpen
          : isSideBarOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$PlaylistScreenStateImplImplCopyWith<$Res>
    implements $PlaylistScreenStateCopyWith<$Res> {
  factory _$$$PlaylistScreenStateImplImplCopyWith(
          _$$PlaylistScreenStateImplImpl value,
          $Res Function(_$$PlaylistScreenStateImplImpl) then) =
      __$$$PlaylistScreenStateImplImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<VideoEntity>? videos,
      PlaylistStateResponseModel playlist,
      bool isSideBarOpen,
      bool isLoading});
}

/// @nodoc
class __$$$PlaylistScreenStateImplImplCopyWithImpl<$Res>
    extends _$PlaylistScreenStateCopyWithImpl<$Res,
        _$$PlaylistScreenStateImplImpl>
    implements _$$$PlaylistScreenStateImplImplCopyWith<$Res> {
  __$$$PlaylistScreenStateImplImplCopyWithImpl(
      _$$PlaylistScreenStateImplImpl _value,
      $Res Function(_$$PlaylistScreenStateImplImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = freezed,
    Object? playlist = null,
    Object? isSideBarOpen = null,
    Object? isLoading = null,
  }) {
    return _then(_$$PlaylistScreenStateImplImpl(
      videos: freezed == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<VideoEntity>?,
      playlist: null == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as PlaylistStateResponseModel,
      isSideBarOpen: null == isSideBarOpen
          ? _value.isSideBarOpen
          : isSideBarOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$$PlaylistScreenStateImplImpl implements _$PlaylistScreenStateImpl {
  _$$PlaylistScreenStateImplImpl(
      {final List<VideoEntity>? videos,
      required this.playlist,
      this.isSideBarOpen = false,
      this.isLoading = true})
      : _videos = videos;

  final List<VideoEntity>? _videos;
  @override
  List<VideoEntity>? get videos {
    final value = _videos;
    if (value == null) return null;
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PlaylistStateResponseModel playlist;
  @override
  @JsonKey()
  final bool isSideBarOpen;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'PlaylistScreenState(videos: $videos, playlist: $playlist, isSideBarOpen: $isSideBarOpen, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$PlaylistScreenStateImplImpl &&
            const DeepCollectionEquality().equals(other._videos, _videos) &&
            (identical(other.playlist, playlist) ||
                other.playlist == playlist) &&
            (identical(other.isSideBarOpen, isSideBarOpen) ||
                other.isSideBarOpen == isSideBarOpen) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_videos),
      playlist,
      isSideBarOpen,
      isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$PlaylistScreenStateImplImplCopyWith<_$$PlaylistScreenStateImplImpl>
      get copyWith => __$$$PlaylistScreenStateImplImplCopyWithImpl<
          _$$PlaylistScreenStateImplImpl>(this, _$identity);
}

abstract class _$PlaylistScreenStateImpl implements PlaylistScreenState {
  factory _$PlaylistScreenStateImpl(
      {final List<VideoEntity>? videos,
      required final PlaylistStateResponseModel playlist,
      final bool isSideBarOpen,
      final bool isLoading}) = _$$PlaylistScreenStateImplImpl;

  @override
  List<VideoEntity>? get videos;
  @override
  PlaylistStateResponseModel get playlist;
  @override
  bool get isSideBarOpen;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$$PlaylistScreenStateImplImplCopyWith<_$$PlaylistScreenStateImplImpl>
      get copyWith => throw _privateConstructorUsedError;
}
