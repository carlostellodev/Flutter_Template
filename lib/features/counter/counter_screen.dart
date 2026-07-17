import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter_provider.dart';

// ConsumerWidget = widget que puede "leer" providers (StatelessWidget normal no puede).
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider); // escucha cambios, repinta al cambiar

    return Scaffold(
      appBar: AppBar(title: const Text('Mi primera app Flutter')),
      body: Center(
        child: Text('Valor: $count', style: Theme.of(context).textTheme.headlineMedium),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
