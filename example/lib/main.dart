import 'main.mapper.g.dart';

class Person with Mappable {
  final String name;
  final int age;
  final Car? car;

  Person(this.name, {this.age = 18, this.car});

  // optional factory wrapper
  factory Person.fromMap(Map<String, dynamic> map) => Mapper.fromMap(map);
}

enum Brand { Toyota, Audi, BMW }

class Car with Mappable {
  final double miles;
  final Brand brand;

  const Car(int drivenKm, this.brand) : miles = drivenKm * 0.62;

  int get drivenKm => (miles / 0.62).round();
}

class Box<T> {
  int size;
  T content;

  Box(this.size, {required this.content});
}

class Confetti {
  String color;
  Confetti(this.color);
}

void main() {
  // decode from json string
  String personJson = '{"name": "Max", "car": {"driven_km": 1000, "brand": "audi"}}';
  Person person = Mapper.fromJson(personJson);
  print(person); // Person(name: Max, age: 18, car: Car(miles: 620.0, brand: Brand.Audi))

  // make a copy
  Person person2 = person.copyWith(name: 'Anna', age: 20);
  print(person2); // Person(name: Anna, age: 20, car: ...

  // encode to map
  Map<String, dynamic> map = person.toMap();
  print(map); // {name: Max, age: 18, car: {driven_km: 1000, brand: audi}}

  // decode from map
  Person person3 = Person.fromMap(map);
  print(person3); // Person(name: Max, age: 18, car: ...

  // check equality
  print(person3 == person); // true

  // directly convert to json
  print(person3.toJson()); // {"name":"Max","age":18,"car":{...

  // optionally use Mapper functions
  print(Mapper.isEqual(person, person3)); // true
  print(Mapper.asString(person)); // Person(name: Max, age: 18, ...

  // use generic objects
  Box<Confetti> box = Box(10, content: Confetti('Rainbow'));
  String boxJson = box.toJson();
  print(boxJson); // {"size":10,"content":{"color":"Rainbow"},"_type":"Box<Confetti>"}

  // ... somewhere else
  dynamic whatAmI = Mapper.fromJson(boxJson);
  print(whatAmI.runtimeType); // Box<Confetti>

  // also works with lists
  List<Box<double>> boxes = Mapper.fromJson('[{"size": 10, "content": 0.1}, {"size": 2, "content": 12.34}]');
  print(boxes[1].content); // 12.34
}