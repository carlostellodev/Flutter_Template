import 'package:go_router/go_router.dart';

import 'features/counter/counter_screen.dart';

// go_router = define rutas por string ("/", "/detalle/123"). Escala mejor que Navigator manual.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CounterScreen(),
    ),
  ],
);
