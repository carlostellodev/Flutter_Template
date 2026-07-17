import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'counter_provider.dart';

// ConsumerWidget = widget que puede "leer" providers (StatelessWidget normal no puede).
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(
      counterProvider,
    ); // escucha cambios, repinta al cambiar

    return Scaffold(
      appBar: AppBar(title: const Text('Mi primera app Flutter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Valor: $count',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/counter2'),
              child: const Text('Ir a Contador 2'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/person'),
              child: const Text('Ir a Freezed demo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
