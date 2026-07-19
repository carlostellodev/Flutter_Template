import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/features/example/data/posts_repository.dart';
import 'package:my_app/features/example/domain/post.dart';
import 'package:my_app/main.dart';

/// Repo falso: en tests NUNCA se llama a la red.
/// Patrón clave de Riverpod: overrides sustituyen providers reales por fakes.
class _FakePostsRepository implements PostsRepository {
  @override
  Future<List<Post>> fetchPosts() async => const [
        Post(id: 1, userId: 1, title: 'Post de prueba', body: 'Contenido'),
      ];
}

void main() {
  testWidgets('Arranca en Inicio y el tab Posts pinta el listado',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postsRepositoryProvider.overrideWithValue(_FakePostsRepository()),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Tab inicial: Inicio con saludo.
    expect(find.text('¡Hola! 👋'), findsOneWidget);

    // Cambia al tab Posts y comprueba el listado (del repo fake).
    await tester.tap(find.text('Posts'));
    await tester.pumpAndSettle();

    expect(find.text('Post de prueba'), findsOneWidget);
  });
}
