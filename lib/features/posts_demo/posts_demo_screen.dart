import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'posts_provider.dart';

class PostsDemoScreen extends ConsumerWidget {
  const PostsDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postsProvider); // AsyncValue<List<String>>

    return Scaffold(
      appBar: AppBar(title: const Text('AsyncValue demo (posts)')),
      body: Center(
        // .when obliga a cubrir los 3 casos, igual que el switch de antes pero genérico.
        child: asyncPosts.when(
          loading: () => const CircularProgressIndicator(),
          data: (posts) => Column(
            mainAxisSize: MainAxisSize.min,
            children: posts.map((p) => Text(p)).toList(),
          ),
          error: (err, stack) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$err', style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () => ref.read(postsProvider.notifier).reintentar(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
