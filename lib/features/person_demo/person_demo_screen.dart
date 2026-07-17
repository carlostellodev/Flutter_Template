import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'person_provider.dart';

class PersonDemoScreen extends ConsumerWidget {
  const PersonDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final person = ref.watch(personProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Freezed demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nombre: ${person.name}'),
            Text('Edad: ${person.age}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(personProvider.notifier).cumplirAnios(),
              child: const Text('Cumplir años'),
            ),
            ElevatedButton(
              onPressed: () => ref
                  .read(personProvider.notifier)
                  .cambiarNombre('Luis'),
              child: const Text('Cambiar nombre a Luis'),
            ),
          ],
        ),
      ),
    );
  }
}
