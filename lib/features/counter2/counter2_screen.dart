import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter2_provider.dart';

class Counter2Screen extends ConsumerWidget {
  const Counter2Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counter2Provider);
    return Scaffold(
      appBar: AppBar(title: const Text('Contador 2')),
      body: Center(child: Text('Valor: $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counter2Provider.notifier).decrement(),
        child: const Icon(Icons.remove),
      ),
    );
  }
}
