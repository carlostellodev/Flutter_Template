import 'package:my_app/features/example/data/posts_repository.dart';
import 'package:my_app/features/example/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_provider.g.dart';

/// `build()` async -> Riverpod expone `AsyncValue<List<Post>>` automático:
/// loading mientras corre, data al retornar, error si lanza excepción.
/// NO crees sealed classes manuales para loading/error: AsyncValue ya lo es.
@riverpod
class Posts extends _$Posts {
  @override
  Future<List<Post>> build() =>
      ref.watch(postsRepositoryProvider).fetchPosts();

  /// Re-ejecuta build() desde cero (pull-to-refresh, botón reintentar...).
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
