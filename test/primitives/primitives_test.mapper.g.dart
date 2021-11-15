import 'package:dart_mappable/dart_mappable.dart';

import 'primitives_test.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  ItemsMapper._(),
  ItemMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class ItemsMapper extends BaseMapper<Items> {
  ItemsMapper._();

  @override Function get decoder => decode;
  Items decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  Items fromMap(Map<String, dynamic> map) => Items(map.getList('items'), map.getMap('items2'));

  @override Function get encoder => (Items v) => encode(v);
  dynamic encode(Items v) => toMap(v);
  Map<String, dynamic> toMap(Items i) => {'items': Mapper.toValue(i.items), 'items2': Mapper.toValue(i.items2)};

  @override String? stringify(Items self) => 'Items(items: ${Mapper.asString(self.items)}, items2: ${Mapper.asString(self.items2)})';
  @override int? hash(Items self) => Mapper.hash(self.items) ^ Mapper.hash(self.items2);
  @override bool? equals(Items self, Items other) => Mapper.isEqual(self.items, other.items) && Mapper.isEqual(self.items2, other.items2);

  @override Function get typeFactory => (f) => f<Items>();
}

extension ItemsMapperExtension on Items {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ItemsCopyWith<Items> get copyWith => ItemsCopyWith(this, _$identity);
}

abstract class ItemsCopyWith<$R> {
  factory ItemsCopyWith(Items value, Then<Items, $R> then) = _ItemsCopyWithImpl<$R>;
  $R call({List<Item>? items, Map<int, Item>? items2});
}

class _ItemsCopyWithImpl<$R> extends BaseCopyWith<Items, $R> implements ItemsCopyWith<$R> {
  _ItemsCopyWithImpl(Items value, Then<Items, $R> then) : super(value, then);

  @override $R call({List<Item>? items, Map<int, Item>? items2}) => _then(Items(items ?? _value.items, items2 ?? _value.items2));
}

class ItemMapper extends BaseMapper<Item> {
  ItemMapper._();

  @override Function get decoder => decode;
  Item decode(dynamic v) => _checked(v, (Map<String, dynamic> map) => fromMap(map));
  Item fromMap(Map<String, dynamic> map) => Item(map.get('index'));

  @override Function get encoder => (Item v) => encode(v);
  dynamic encode(Item v) => toMap(v);
  Map<String, dynamic> toMap(Item i) => {'index': Mapper.toValue(i.index)};

  @override String? stringify(Item self) => 'Item(index: ${Mapper.asString(self.index)})';
  @override int? hash(Item self) => Mapper.hash(self.index);
  @override bool? equals(Item self, Item other) => Mapper.isEqual(self.index, other.index);

  @override Function get typeFactory => (f) => f<Item>();
}

extension ItemMapperExtension on Item {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ItemCopyWith<Item> get copyWith => ItemCopyWith(this, _$identity);
}

abstract class ItemCopyWith<$R> {
  factory ItemCopyWith(Item value, Then<Item, $R> then) = _ItemCopyWithImpl<$R>;
  $R call({int? index});
}

class _ItemCopyWithImpl<$R> extends BaseCopyWith<Item, $R> implements ItemCopyWith<$R> {
  _ItemCopyWithImpl(Item value, Then<Item, $R> then) : super(value, then);

  @override $R call({int? index}) => _then(Item(index ?? _value.index));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===




// === GENERATED UTILITY CODE ===


class _Mapper extends MapperContainer {
  _Mapper._() : super(_mappers);
}

class Mapper {
  Mapper._();

  static late _Mapper i = _Mapper._();

  static T fromValue<T>(dynamic value) => i.fromValue<T>(value);
  static T fromMap<T>(Map<String, dynamic> map) => i.fromMap<T>(map);
  static T fromIterable<T>(Iterable<dynamic> iterable) =>
      i.fromIterable<T>(iterable);
  static T fromJson<T>(String json) => i.fromJson<T>(json);

  static dynamic toValue(dynamic value) => i.toValue(value);
  static Map<String, dynamic> toMap(dynamic object) => i.toMap(object);
  static Iterable<dynamic> toIterable(dynamic object) => i.toIterable(object);
  static String toJson(dynamic object) => i.toJson(object);

  static bool isEqual(dynamic value, Object? other) => i.isEqual(value, other);
  static int hash(dynamic value) => i.hash(value);
  static String asString(dynamic value) => i.asString(value);

  static void use<T>(BaseMapper<T> mapper) => i.use<T>(mapper);
  static BaseMapper<T>? unuse<T>() => i.unuse<T>();
  static void useAll(List<BaseMapper> mappers) => i.useAll(mappers);

  static BaseMapper<T>? get<T>([Type? type]) => i.get<T>(type);
  static List<BaseMapper> getAll() => i.getAll();
}

mixin Mappable {
  BaseMapper? get _mapper => Mapper.get(runtimeType);

  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);

  @override
  String toString() => _mapper?.stringify(this) ?? super.toString();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (runtimeType == other.runtimeType &&
          (_mapper?.equals(this, other) ?? super == other));
  @override
  int get hashCode => _mapper?.hash(this) ?? super.hashCode;
}

final _checked = MapperContainer.checked;

T _hookedDecode<T>(MappingHooks hooks, dynamic value, T Function(dynamic value) fn) {
  var v = hooks.beforeDecode(value);
  if (v is! T) v = fn(v);
  return hooks.afterDecode(v) as T;
}
dynamic _hookedEncode<T>(MappingHooks hooks, T value, dynamic Function(T value) fn) {
  var v = hooks.beforeEncode(value);
  if (v is T) v = fn(v);
  return hooks.afterEncode(v);
}

dynamic _toValue(dynamic value, {MappingHooks? hooks}) {
  if (hooks == null) {
    return Mapper.toValue(value);
  } else {
    return hooks.afterEncode(Mapper.toValue(hooks.beforeEncode(value)));
  }
}

extension MapGet on Map<String, dynamic> {
  T get<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      throw MapperException('Parameter $key is required.');
    }
    return Mapper.fromValue<T>(v);
  });

  T? getOpt<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      return null;
    }
    return Mapper.fromValue<T>(v);
  });

  List<T> getList<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      throw MapperException('Parameter $key is required.');
    } else if (v is! List) {
      throw MapperException('Parameter $v with key $key is not a List');
    }
    return v.map((dynamic item) => Mapper.fromValue<T>(item)).toList();
  });

  List<T>? getListOpt<T>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      return null;
    } else if (v is! List) {
      throw MapperException('Parameter $v with key $key is not a List');
    }
    return v.map((dynamic item) => Mapper.fromValue<T>(item)).toList();
  });

  Map<K, V> getMap<K, V>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      throw MapperException('Parameter $key is required.');
    } else if (v is! Map) {
      throw MapperException('Parameter $v with key $key is not a Map');
    }
    return v.map((dynamic key, dynamic value) => MapEntry(Mapper.fromValue<K>(key), Mapper.fromValue<V>(value)));
  });

  Map<K, V>? getMapOpt<K, V>(String key, {MappingHooks? hooks}) => hooked(hooks, key, (v) {
    if (v == null) {
      return null;
    } else if (v is! Map) {
      throw MapperException('Parameter $v with key $key is not a Map');
    }
    return v.map((dynamic key, dynamic value) => MapEntry(Mapper.fromValue<K>(key), Mapper.fromValue<V>(value)));
  });

  T hooked<T>(MappingHooks? hooks, String key, T Function(dynamic v) fn) {
    if (hooks == null) {
      return fn(this[key]);
    } else {
      return hooks.afterDecode(fn(hooks.beforeDecode(this[key]))) as T;
    }
  }
}

class _None { const _None(); }
const _none = _None();

T _$identity<T>(T value) => value;
typedef Then<$T, $R> = $R Function($T);

class BaseCopyWith<$T, $R> {
  BaseCopyWith(this._value, this._then);

  final $T _value;
  final Then<$T, $R> _then;
  
  T or<T>(Object? _v, T v) => _v == _none ? v : _v as T;
}
