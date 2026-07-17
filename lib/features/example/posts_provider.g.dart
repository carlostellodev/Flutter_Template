// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `build()` async -> Riverpod expone AsyncValue<List<Post>> automático:
/// loading mientras corre, data al retornar, error si lanza excepción.
/// NO crees sealed classes manuales para loading/error: AsyncValue ya lo es.

@ProviderFor(Posts)
final postsProvider = PostsProvider._();

/// `build()` async -> Riverpod expone AsyncValue<List<Post>> automático:
/// loading mientras corre, data al retornar, error si lanza excepción.
/// NO crees sealed classes manuales para loading/error: AsyncValue ya lo es.
final class PostsProvider extends $AsyncNotifierProvider<Posts, List<Post>> {
  /// `build()` async -> Riverpod expone AsyncValue<List<Post>> automático:
  /// loading mientras corre, data al retornar, error si lanza excepción.
  /// NO crees sealed classes manuales para loading/error: AsyncValue ya lo es.
  PostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsHash();

  @$internal
  @override
  Posts create() => Posts();
}

String _$postsHash() => r'596f5ab4bbb6031364f1dba5c606512ddd877dca';

/// `build()` async -> Riverpod expone AsyncValue<List<Post>> automático:
/// loading mientras corre, data al retornar, error si lanza excepción.
/// NO crees sealed classes manuales para loading/error: AsyncValue ya lo es.

abstract class _$Posts extends $AsyncNotifier<List<Post>> {
  FutureOr<List<Post>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Post>>, List<Post>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Post>>, List<Post>>,
              AsyncValue<List<Post>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
