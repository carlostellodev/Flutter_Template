// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Posts)
final postsProvider = PostsProvider._();

final class PostsProvider extends $NotifierProvider<Posts, PostsState> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostsState>(value),
    );
  }
}

String _$postsHash() => r'42eb34fa2c69cde07677bee88712a98084700f26';

abstract class _$Posts extends $Notifier<PostsState> {
  PostsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PostsState, PostsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostsState, PostsState>,
              PostsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
