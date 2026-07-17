import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'posts_state.dart';

part 'posts_provider.g.dart';

@riverpod
class Posts extends _$Posts {
  @override
  PostsState build() {
    _fetch();
    return const PostsState.loading(); // estado inicial: cargando
  }

  Future<void> _fetch() async {
    state = const PostsState.loading();
    await Future.delayed(const Duration(seconds: 1)); // simula llamada red

    final fallo = DateTime.now().second.isEven; // simula fallo aleatorio
    if (fallo) {
      state = const PostsState.error('No se pudo conectar al servidor');
    } else {
      state = const PostsState.success(['Post 1', 'Post 2', 'Post 3']);
    }
  }

  void reintentar() => _fetch();
}
