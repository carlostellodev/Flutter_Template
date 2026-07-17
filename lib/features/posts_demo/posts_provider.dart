import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_provider.g.dart';

@riverpod
class Posts extends _$Posts {
  @override
  Future<List<String>> build() async {
    await Future.delayed(const Duration(seconds: 1)); // simula llamada red

    final fallo = DateTime.now().second.isEven; // simula fallo aleatorio
    if (fallo) {
      throw Exception('No se pudo conectar al servidor'); // Riverpod captura esto solo -> AsyncError
    }
    return ['Post 1', 'Post 2', 'Post 3'];
  }

  // reintentar: vuelve a ejecutar build() de cero, estado pasa a loading mientras tanto.
  Future<void> reintentar() async {
    ref.invalidateSelf();
    await future; // espera a que termine el nuevo build()
  }
}
