import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'person.dart';

part 'person_provider.g.dart';

@riverpod
class PersonNotifier extends _$PersonNotifier {
  @override
  Person build() => const Person(name: 'Ana', age: 25);

  // copyWith crea Person NUEVO con age cambiado, no muta el original.
  void cumplirAnios() => state = state.copyWith(age: state.age + 1);

  void cambiarNombre(String nuevoNombre) =>
      state = state.copyWith(name: nuevoNombre);
}
