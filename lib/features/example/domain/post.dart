import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// Modelo de ejemplo (jsonplaceholder). Copia este patrón para tus modelos:
/// freezed genera copyWith/==/toString, json_serializable genera fromJson/toJson.
@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
