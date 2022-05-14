import 'package:flutter/foundation.dart' show immutable;
import 'package:testingrxdart_course/models/thing.dart';

enum AnimalType { dog, cat, rabbit, unknown }

@immutable
class Animal extends Thing {
  final AnimalType type;

  const Animal({
    required String name,
    required this.type,
  }) : super(name: name);

  @override
  String toString() => 'Animal, name: $name, type: $type';

  factory Animal.fromJson(Map<String, dynamic> json) {
    final AnimalType animalType;
    switch ((json["type"] as String).toLowerCase().trim()) {
      case "rabbit":
        animalType = AnimalType.rabbit;
        break;
      case "dog":
        animalType = AnimalType.dog;
        break;
      case "cat":
        animalType = AnimalType.cat;
        break;
      default:
        animalType = AnimalType.unknown;
    }
    return Animal(
      name: json["name"] as String,
      type: animalType,
    );
  }
}
