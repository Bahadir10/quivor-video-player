// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_playlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreatePlaylistScreenState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get choise => throw _privateConstructorUsedError;
  List<String>? get playlistItems => throw _privateConstructorUsedError;
  bool get isSideBarOpen => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreatePlaylistScreenStateCopyWith<CreatePlaylistScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePlaylistScreenStateCopyWith<$Res> {
  factory $CreatePlaylistScreenStateCopyWith(CreatePlaylistScreenState value,
          $Res Function(CreatePlaylistScreenState) then) =
      _$CreatePlaylistScreenStateCopyWithImpl<$Res, CreatePlaylistScreenState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool choise,
      List<String>? playlistItems,
      bool isSideBarOpen});
}

/// @nodoc
class _$CreatePlaylistScreenStateCopyWithImpl<$Res,
        $Val extends CreatePlaylistScreenState>
    implements $CreatePlaylistScreenStateCopyWith<$Res> {
  _$CreatePlaylistScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? choise = null,
    Object? playlistItems = freezed,
    Object? isSideBarOpen = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      choise: null == choise
          ? _value.choise
          : choise // ignore: cast_nullable_to_non_nullable
              as bool,
      playlistItems: freezed == playlistItems
          ? _value.playlistItems
          : playlistItems // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isSideBarOpen: null == isSideBarOpen
          ? _value.isSideBarOpen
          : isSideBarOpen // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$CreatePlaylistScreenStateImplImplCopyWith<$Res>
    implements $CreatePlaylistScreenStateCopyWith<$Res> {
  factory _$$$CreatePlaylistScreenStateImplImplCopyWith(
          _$$CreatePlaylistScreenStateImplImpl value,
          $Res Function(_$$CreatePlaylistScreenStateImplImpl) then) =
      __$$$CreatePlaylistScreenStateImplImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool choise,
      List<String>? playlistItems,
      bool isSideBarOpen});
}

/// @nodoc
class __$$$CreatePlaylistScreenStateImplImplCopyWithImpl<$Res>
    extends _$CreatePlaylistScreenStateCopyWithImpl<$Res,
        _$$CreatePlaylistScreenStateImplImpl>
    implements _$$$CreatePlaylistScreenStateImplImplCopyWith<$Res> {
  __$$$CreatePlaylistScreenStateImplImplCopyWithImpl(
      _$$CreatePlaylistScreenStateImplImpl _value,
      $Res Function(_$$CreatePlaylistScreenStateImplImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? choise = null,
    Object? playlistItems = freezed,
    Object? isSideBarOpen = null,
  }) {
    return _then(_$$CreatePlaylistScreenStateImplImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      choise: null == choise
          ? _value.choise
          : choise // ignore: cast_nullable_to_non_nullable
              as bool,
      playlistItems: freezed == playlistItems
          ? _value._playlistItems
          : playlistItems // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isSideBarOpen: null == isSideBarOpen
          ? _value.isSideBarOpen
          : isSideBarOpen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$$CreatePlaylistScreenStateImplImpl
    implements _$CreatePlaylistScreenStateImpl {
  _$$CreatePlaylistScreenStateImplImpl(
      {this.isLoading = false,
      this.choise = false,
      final List<String>? playlistItems,
      this.isSideBarOpen = false})
      : _playlistItems = playlistItems;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool choise;
  final List<String>? _playlistItems;
  @override
  List<String>? get playlistItems {
    final value = _playlistItems;
    if (value == null) return null;
    if (_playlistItems is EqualUnmodifiableListView) return _playlistItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isSideBarOpen;

  @override
  String toString() {
    return 'CreatePlaylistScreenState(isLoading: $isLoading, choise: $choise, playlistItems: $playlistItems, isSideBarOpen: $isSideBarOpen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$CreatePlaylistScreenStateImplImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.choise, choise) || other.choise == choise) &&
            const DeepCollectionEquality()
                .equals(other._playlistItems, _playlistItems) &&
            (identical(other.isSideBarOpen, isSideBarOpen) ||
                other.isSideBarOpen == isSideBarOpen));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, choise,
      const DeepCollectionEquality().hash(_playlistItems), isSideBarOpen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$CreatePlaylistScreenStateImplImplCopyWith<
          _$$CreatePlaylistScreenStateImplImpl>
      get copyWith => __$$$CreatePlaylistScreenStateImplImplCopyWithImpl<
          _$$CreatePlaylistScreenStateImplImpl>(this, _$identity);
}

abstract class _$CreatePlaylistScreenStateImpl
    implements CreatePlaylistScreenState {
  factory _$CreatePlaylistScreenStateImpl(
      {final bool isLoading,
      final bool choise,
      final List<String>? playlistItems,
      final bool isSideBarOpen}) = _$$CreatePlaylistScreenStateImplImpl;

  @override
  bool get isLoading;
  @override
  bool get choise;
  @override
  List<String>? get playlistItems;
  @override
  bool get isSideBarOpen;
  @override
  @JsonKey(ignore: true)
  _$$$CreatePlaylistScreenStateImplImplCopyWith<
          _$$CreatePlaylistScreenStateImplImpl>
      get copyWith => throw _privateConstructorUsedError;
}
