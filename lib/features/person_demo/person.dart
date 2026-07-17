import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart'; // genera: copyWith, ==, hashCode, toString
part 'person.g.dart'; // genera: fromJson/toJson (por json_serializable)

@freezed
abstract class Person with _$Person {
  const factory Person({
    required String name,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
