// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SetAndMapState {
  Set<InventoryItem> get items => throw _privateConstructorUsedError;
  Map<String, DocumentReference<InventoryItem>> get docs =>
      throw _privateConstructorUsedError;

  /// Create a copy of SetAndMapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SetAndMapStateCopyWith<SetAndMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetAndMapStateCopyWith<$Res> {
  factory $SetAndMapStateCopyWith(
          SetAndMapState value, $Res Function(SetAndMapState) then) =
      _$SetAndMapStateCopyWithImpl<$Res, SetAndMapState>;
  @useResult
  $Res call(
      {Set<InventoryItem> items,
      Map<String, DocumentReference<InventoryItem>> docs});
}

/// @nodoc
class _$SetAndMapStateCopyWithImpl<$Res, $Val extends SetAndMapState>
    implements $SetAndMapStateCopyWith<$Res> {
  _$SetAndMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetAndMapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? docs = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Set<InventoryItem>,
      docs: null == docs
          ? _value.docs
          : docs // ignore: cast_nullable_to_non_nullable
              as Map<String, DocumentReference<InventoryItem>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetAndMapStateImplCopyWith<$Res>
    implements $SetAndMapStateCopyWith<$Res> {
  factory _$$SetAndMapStateImplCopyWith(_$SetAndMapStateImpl value,
          $Res Function(_$SetAndMapStateImpl) then) =
      __$$SetAndMapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Set<InventoryItem> items,
      Map<String, DocumentReference<InventoryItem>> docs});
}

/// @nodoc
class __$$SetAndMapStateImplCopyWithImpl<$Res>
    extends _$SetAndMapStateCopyWithImpl<$Res, _$SetAndMapStateImpl>
    implements _$$SetAndMapStateImplCopyWith<$Res> {
  __$$SetAndMapStateImplCopyWithImpl(
      _$SetAndMapStateImpl _value, $Res Function(_$SetAndMapStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetAndMapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? docs = null,
  }) {
    return _then(_$SetAndMapStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Set<InventoryItem>,
      docs: null == docs
          ? _value._docs
          : docs // ignore: cast_nullable_to_non_nullable
              as Map<String, DocumentReference<InventoryItem>>,
    ));
  }
}

/// @nodoc

class _$SetAndMapStateImpl implements _SetAndMapState {
  const _$SetAndMapStateImpl(
      {required final Set<InventoryItem> items,
      required final Map<String, DocumentReference<InventoryItem>> docs})
      : _items = items,
        _docs = docs;

  final Set<InventoryItem> _items;
  @override
  Set<InventoryItem> get items {
    if (_items is EqualUnmodifiableSetView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_items);
  }

  final Map<String, DocumentReference<InventoryItem>> _docs;
  @override
  Map<String, DocumentReference<InventoryItem>> get docs {
    if (_docs is EqualUnmodifiableMapView) return _docs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_docs);
  }

  @override
  String toString() {
    return 'SetAndMapState(items: $items, docs: $docs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetAndMapStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._docs, _docs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_docs));

  /// Create a copy of SetAndMapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetAndMapStateImplCopyWith<_$SetAndMapStateImpl> get copyWith =>
      __$$SetAndMapStateImplCopyWithImpl<_$SetAndMapStateImpl>(
          this, _$identity);
}

abstract class _SetAndMapState implements SetAndMapState {
  const factory _SetAndMapState(
          {required final Set<InventoryItem> items,
          required final Map<String, DocumentReference<InventoryItem>> docs}) =
      _$SetAndMapStateImpl;

  @override
  Set<InventoryItem> get items;
  @override
  Map<String, DocumentReference<InventoryItem>> get docs;

  /// Create a copy of SetAndMapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetAndMapStateImplCopyWith<_$SetAndMapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
