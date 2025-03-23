// ignore_for_file: deprecated_member_use_from_same_package

import 'package:dart_mappable/dart_mappable.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('Mapper utils', () {
    test('Use and unuse Mapper', () {
      var container = MapperContainer();
      var mapper = MapperContainer.defaults.unuse<int>()!;

      expect(
        () => container.fromValue<int>('2'),
        throwsMapperException(MapperException.chain(
          MapperMethod.decode,
          '(int)',
          MapperException.unknownType(int),
        )),
      );

      expect(
        () => container.toValue<int>(2),
        throwsMapperException(MapperException.chain(
          MapperMethod.encode,
          '[2]',
          MapperException.unknownType(int),
        )),
      );

      MapperContainer.defaults.use(mapper);

      expect(container.fromValue<int>('2'), equals(2));

      container
          .use(PrimitiveMapper((value) => int.parse(value.toString()) * 10));

      expect(container.fromValue<int>('2'), 20);

      expect(container.getAll(), hasLength(1));
    });

    test('link containers', () {
      var containerA = MapperContainer();
      var containerB = MapperContainer();

      var mapper = MapperContainer.defaults.unuse<int>()!;

      containerB.use(mapper);

      expect(
        () => containerA.fromValue<int>('2'),
        throwsMapperException(MapperException.chain(
          MapperMethod.decode,
          '(int)',
          MapperException.unknownType(int),
        )),
      );

      expect(containerB.fromValue<int>('2'), equals(2));

      containerA.link(containerB);

      expect(containerA.fromValue<int>('2'), equals(2));

      MapperContainer.defaults.use(mapper);
    });

    test('iterables', () {
      var container = MapperContainer();

      expect(
        container.fromIterable<List<int>>(['2', 1.5, 0]),
        equals([2, 2, 0]),
      );

      expect(
        container.toIterable([DateTime.utc(2000)]),
        equals(['2000-01-01T00:00:00.000Z']),
      );

      expect(
        () => container.toIterable(1),
        throwsMapperException(
            MapperException.incorrectEncoding(int, 'Iterable', int)),
      );
    });

    test('equals and tostring', () {
      var container = MapperContainer();

      var mapper = MapperContainer.defaults.unuse<int>()!;

      expect(container.isEqual(null, 2), isFalse);
      expect(container.hash(null), equals(null.hashCode));
      expect(container.asString(null), equals(null.toString()));

      expect(container.isEqual(2, 2), isTrue);
      expect(container.hash(2), equals(2.hashCode));
      expect(container.asString(2), equals(2.toString()));

      MapperContainer.defaults.use(mapper);
    });

    test('Encode Mapper for specific class', () {
      var container = MapperContainer();

      container.useForClass<ModelA, DateTime>(UsaDateTimaMapper());
      container.useForClass<ModelB, DateTime>(EuDateTimaMapper());

      final a = container.fromClassValue<ModelA, DateTime>('12/24/2025');
      final b = container.fromClassValue<ModelB, DateTime>('24.12.2025');
      final c = container.fromValue<DateTime>(
          DateTime(2025, 12, 24).toUtc().toIso8601String());

      expect(a, DateTime(2025, 12, 24));
      expect(b, DateTime(2025, 12, 24));
      expect(c, DateTime(2025, 12, 24).toUtc());
    });

    test('Decode Mapper for specific class', () {
      var container = MapperContainer();

      container.use(ModelAMapper());
      container.use(ModelBMapper());
      container.use(ModelCMapper());

      container.useForClass<ModelA, DateTime>(UsaDateTimaMapper());
      container.useForClass<ModelB, DateTime>(EuDateTimaMapper());

      final modelA = ModelA(usaTime: DateTime(2025, 12, 24));
      final modelB = ModelB(euTime: DateTime(2025, 12, 24));
      final modelC = ModelC(time: DateTime(2025, 12, 24));

      final a = container.toValue(modelA);
      final b = container.toValue(modelB);
      final c = container.toValue(modelC);

      expect(a, {'usaTime': '12/24/2025'});
      expect(b, {'euTime': '24.12.2025'});
      expect(c, {'time': DateTime(2025, 12, 24).toUtc().toIso8601String()});
    });
  });
}

class UsaDateTimaMapper extends SimpleMapper<DateTime> {
  const UsaDateTimaMapper();

  @override
  DateTime decode(Object value) {
    final str = value as String;
    final ints = str.split('/').map((e) => int.parse(e)).toList();
    return DateTime(ints[2], ints[0], ints[1]);
  }

  @override
  Object? encode(DateTime self) {
    return '${self.month}/${self.day}/${self.year}';
  }
}

class EuDateTimaMapper extends SimpleMapper<DateTime> {
  const EuDateTimaMapper();

  @override
  DateTime decode(Object value) {
    final str = value as String;
    final ints = str.split('.').map((e) => int.parse(e)).toList();
    return DateTime(ints[2], ints[1], ints[0]);
  }

  @override
  Object? encode(DateTime self) {
    return '${self.day}.${self.month}.${self.year}';
  }
}

class ModelAMapper extends ClassMapperBase<ModelA> {
  static DateTime _usaTime(ModelA v) => v.usaTime;
  static const Field<ModelA, DateTime> _fUsaTime = Field('usaTime', _usaTime);

  @override
  MappableFields<ModelA> get fields => const {#usaTime: _fUsaTime};

  @override
  Function get instantiate => _instantiate;

  static ModelA _instantiate(DecodingData data) {
    return ModelA(usaTime: data.dec(_fUsaTime));
  }
}

class ModelBMapper extends ClassMapperBase<ModelB> {
  static DateTime _euTime(ModelB v) => v.euTime;
  static const Field<ModelB, DateTime> _fEuTime = Field('euTime', _euTime);

  @override
  MappableFields<ModelB> get fields => const {#euTime: _fEuTime};

  @override
  Function get instantiate => _instantiate;

  static ModelB _instantiate(DecodingData data) {
    return ModelB(euTime: data.dec(_fEuTime));
  }
}

class ModelCMapper extends ClassMapperBase<ModelC> {
  static DateTime _time(ModelC v) => v.time;
  static const Field<ModelC, DateTime> _fTime = Field('time', _time);

  @override
  MappableFields<ModelC> get fields => const {#time: _fTime};

  @override
  Function get instantiate => _instantiate;

  static ModelC _instantiate(DecodingData data) {
    return ModelC(time: data.dec(_fTime));
  }
}

// @MappableClass(includeCustomMappers: [UsaDateTimaMapper()])
class ModelA {
  final DateTime usaTime;

  ModelA({required this.usaTime});
}

// @MappableClass(includeCustomMappers: [EuDateTimaMapper()])
class ModelB {
  final DateTime euTime;

  ModelB({required this.euTime});
}

class ModelC {
  final DateTime time;

  ModelC({required this.time});
}
