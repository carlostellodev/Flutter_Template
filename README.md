# my_app

A new Flutter project.

## Primeros pasos que hizo Claude

Qué monté:

lib/
main.dart → arranca app, ProviderScope + MaterialApp.router
router.dart → rutas (go_router)
features/counter/
counter_provider.dart → estado (Riverpod), @riverpod genera código
counter_provider.g.dart → generado, no tocar
counter_screen.dart → UI, lee provider con ref.watch
Stack: Riverpod (state) + go_router (nav) + freezed/json_serializable (listos, sin usar aún) + build_runner (codegen).

Cómo correr:

flutter run # lanza app (elige dispositivo/emulador/chrome)
flutter test # corre tests
dart run build_runner watch --delete-conflicting-outputs # regenera código auto al guardar (usar mientras desarrollas)
Conceptos clave que acabas de ver:

@riverpod + part '....g.dart' → escribes poco, codegen genera provider real. Cada vez que cambies provider, corre build_runner.
ConsumerWidget vs StatelessWidget → Consumer puede leer providers.
ref.watch() (repinta al cambiar) vs ref.read() (lee una vez, úsalo en callbacks tipo onPressed).
GoRoute(path: '/') → añadir pantalla = añadir GoRoute nueva aquí.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
