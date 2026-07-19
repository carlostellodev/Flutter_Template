import 'package:go_router/go_router.dart';

import 'package:my_app/features/example/presentation/example_screen.dart';

/// Rutas de la app. Añadir pantalla = añadir GoRoute aquí.
/// Navegar: `context.go('/ruta')` (reemplaza) o `context.push('/ruta')` (apila).
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ExampleScreen()),
  ],
);
