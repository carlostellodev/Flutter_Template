import 'package:dio/dio.dart';
import 'package:my_app/core/api/api_client.dart';
import 'package:my_app/core/api/api_exception.dart';
import 'package:my_app/features/example/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_repository.g.dart';

@Riverpod(keepAlive: true)
PostsRepository postsRepository(Ref ref) =>
    PostsRepository(ref.watch(apiClientProvider));

/// Repositorio = única capa que habla con la API.
/// Providers/screens nunca usan dio directo: siempre a través de un repositorio.
class PostsRepository {
  const PostsRepository(this._dio);

  final Dio _dio;

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get<List<dynamic>>('/posts');
      return (response.data ?? [])
          .map((json) => Post.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      // Convertimos el error crudo de dio en nuestro error tipado.
      throw ApiException.fromDioException(e);
    }
  }
}
