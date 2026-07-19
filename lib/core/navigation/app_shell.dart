import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scaffold con bottom nav que envuelve las pantallas de los tabs.
/// go_router lo usa vía StatefulShellRoute (ver router.dart): cada tab es una
/// "branch" con su propio stack de navegación y su estado se conserva.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Tocar el tab ya activo -> vuelve a la raíz de ese tab.
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Posts'),
        ],
      ),
    );
  }
}
