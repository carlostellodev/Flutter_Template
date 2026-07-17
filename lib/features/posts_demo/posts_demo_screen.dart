import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'posts_provider.dart';
import 'posts_state.dart';

class PostsDemoScreen extends ConsumerWidget {
  const PostsDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Union demo (posts)')),
      body: Center(
        // switch pattern matching: Dart exige cubrir Loading/Success/Error.
        // Si borras un case, error de compilación (no bug silencioso en runtime).
        child: switch (state) {
          PostsLoading() => const CircularProgressIndicator(),
          PostsSuccess(:final posts) => Column(
            mainAxisSize: MainAxisSize.min,
            children: posts.map((p) => Text(p)).toList(),
          ),
          PostsError(:final message) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () => ref.read(postsProvider.notifier).reintentar(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        },
      ),
    );
  }
}
