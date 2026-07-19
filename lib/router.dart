import 'package:go_router/go_router.dart';
import 'package:my_app/core/navigation/app_shell.dart';
import 'package:my_app/features/example/presentation/example_screen.dart';
import 'package:my_app/features/home/presentation/home_screen.dart';

/// Rutas de la app.
/// StatefulShellRoute = bottom nav: cada branch es un tab con su propio stack
/// (el estado y el historial de cada tab se conservan al cambiar de tab).
/// Pantallas SIN bottom nav (login, detalle fullscreen...): añádelas como
/// GoRoute al mismo nivel que el StatefulShellRoute, fuera de él.
/// Navegar: `context.go('/ruta')` (reemplaza) o `context.push('/ruta')` (apila).
final router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/posts',
              builder: (context, state) => const ExampleScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
