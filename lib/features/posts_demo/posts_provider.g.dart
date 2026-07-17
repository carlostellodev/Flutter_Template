// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Posts)
final postsProvider = PostsProvider._();

final class PostsProvider extends $AsyncNotifierProvider<Posts, List<String>> {
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

String _$postsHash() => r'32799bac74a92790b10db625c5621aad2e6d25bb';

abstract class _$Posts extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
