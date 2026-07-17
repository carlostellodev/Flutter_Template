import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_state.freezed.dart';

// sealed = compilador conoce TODOS los subtipos posibles (Loading/Success/Error).
// Si olvidas manejar uno en un switch, error de compilación, no en runtime.
@freezed
sealed class PostsState with _$PostsState {
  const factory PostsState.loading() = PostsLoading;
  const factory PostsState.success(List<String> posts) = PostsSuccess;
  const factory PostsState.error(String message) = PostsError;
}
