# Flutter Template

Template base para nuevos proyectos Flutter. Stack moderno, arquitectura feature-first, capa de API lista con manejo de errores tipado.

---

## Stack

| Paquete                                    | Para qué sirve                                         |
| ------------------------------------------ | ------------------------------------------------------ |
| `flutter_riverpod` + `riverpod_annotation` | State management. Providers type-safe con codegen      |
| `go_router`                                | Navegación declarativa por rutas string                |
| `freezed` + `json_serializable`            | Modelos inmutables + parseo JSON automático            |
| `dio`                                      | Cliente HTTP con interceptores (auth, logging)         |
| `envied`                                   | Variables de entorno type-safe, compiladas y ofuscadas |
| `flutter_secure_storage`                   | Storage cifrado (tokens, secretos)                     |
| `very_good_analysis`                       | Linting estricto                                       |
| `build_runner`                             | Motor de generación de código (codegen)                |

---

## Setup al duplicar el template

```bash
# 1. Copia la carpeta y renombra
# 2. Cambia el nombre del paquete en pubspec.yaml (name: my_app -> name: tu_app)
#    OJO: los imports usan package:my_app/... — buscar/reemplazar my_app -> tu_app en lib/ y test/
# 3. Configura el entorno
cp .env.example .env        # y edita los valores
# 4. Instala deps y genera código
flutter pub get
dart run build_runner build
# 5. Comprueba que todo está verde
flutter analyze && flutter test
```

## Comandos del día a día

```bash
flutter run                                  # lanzar app (elige dispositivo)
flutter analyze                              # linter/errores estáticos
flutter test                                 # tests
dart run build_runner build                  # regenerar código una vez
dart run build_runner watch                  # regenerar automático al guardar (déjalo corriendo mientras desarrollas)
dart run build_runner clean                  # si el codegen se queda "pillado" con cache viejo
```

Al duplicar: renombrar my_app en pubspec + buscar/reemplazar package:my_app/ en lib/ y test/, copiar .env.example → .env, pub get + build_runner build. Todo en README.

---

## Estructura

```
lib/
  main.dart                     # arranque: ProviderScope + MaterialApp.router + theme
  router.dart                   # TODAS las rutas de la app
  core/                         # infraestructura compartida (no features)
    env/env.dart                # variables de entorno (envied)
    api/api_client.dart         # Dio configurado: baseUrl, timeouts, interceptores
    api/api_exception.dart      # errores de API tipados (sealed class)
    storage/secure_storage.dart # storage cifrado + helpers de token
    theme/app_theme.dart        # ThemeData light/dark centralizado
    navigation/app_shell.dart   # Scaffold con bottom nav (tabs)
  features/                     # 1 feature = 1 carpeta con TODO lo suyo
    home/                       # tab Inicio (saludo de ejemplo)
      presentation/home_screen.dart
    example/                    # feature de referencia (bórrala al empezar tu app)
      domain/                   # QUÉ es la feature: modelos/entidades puros
        post.dart               #   modelo freezed (sin saber nada de API ni UI)
      data/                     # DE DÓNDE salen los datos: repositorios, API, DB
        posts_repository.dart   #   habla con dio, mapea errores a ApiException
      presentation/             # CÓMO se muestra: providers de UI, screens, widgets
        posts_provider.dart     #   estado (AsyncNotifier)
        example_screen.dart     #   UI
```

**Regla feature-first:** cada feature contiene sus modelos, providers, repositorios, screens y widgets. Nada de carpetas globales `screens/`, `models/`, `widgets/` — no escalan.

**Capas dentro de cada feature** (responsabilidades):

| Capa | Contiene | Regla de dependencia |
|---|---|---|
| `domain/` | Modelos/entidades puros (freezed) | No importa NADA de data ni presentation |
| `data/` | Repositorios, llamadas API, DB, cache | Importa domain. Nunca importa presentation |
| `presentation/` | Providers de UI, screens, widgets | Importa domain y data. Nadie la importa a ella |

Dirección de dependencias: `presentation → data → domain`. Si un archivo de `domain/` necesita importar algo de `data/`, algo va mal. En features muy pequeñas (una pantalla sin API) puedes aplanar y saltarte las subcarpetas — capas vacías no aportan.

**`core/` vs `features/`:** core = infraestructura que usan todas las features (API, env, theme). Si algo lo usan 2+ features y no es de negocio, va a core.

---

## Conceptos clave

### Codegen (build_runner)

Varios paquetes generan código por ti (`.g.dart`, `.freezed.dart`). El flujo siempre es:

1. Escribes tu archivo con anotación (`@riverpod`, `@freezed`, `@Envied`) y declaras el `part 'archivo.g.dart';` (aunque no exista aún)
2. Corres `dart run build_runner build` (o tienes `watch` corriendo)
3. Se crea el archivo generado. **Nunca lo edites a mano.**

Si ves errores tipo `Undefined name 'xxxProvider'` o `Target of URI hasn't been generated`, casi siempre = falta correr build_runner.

### Riverpod: Notifier vs Provider

- **Notifier** = clase que TÚ escribes. Motor: contiene estado + métodos que lo cambian.
- **Provider** = variable global que el CODEGEN genera. Enchufe: lo que los widgets usan para conectarse al motor.

```dart
@riverpod
class Counter extends _$Counter {          // <- Notifier (tú)
  @override
  int build() => 0;                        // estado inicial
  void increment() => state++;             // lógica
}
// codegen genera: final counterProvider = ... // <- Provider (generado)
```

**Naming:** clase `XxxNotifier` → provider `xxxProvider` (el sufijo `Notifier` se elimina). Clase `Counter` → `counterProvider`.

**En widgets:**

```dart
class MyScreen extends ConsumerWidget {              // ConsumerWidget, no StatelessWidget
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);        // WATCH: lee + repinta al cambiar
    // ...
    onPressed: () => ref.read(counterProvider.notifier).increment(),  // READ: en callbacks
  }
}
```

- `ref.watch(provider)` → el **estado**. Úsalo en `build()`. Repinta al cambiar.
- `ref.read(provider.notifier)` → el **Notifier** (para llamar métodos). Úsalo en callbacks (`onPressed`...). Nunca `watch` dentro de un callback.

### Freezed (modelos inmutables)

```dart
@freezed
abstract class Post with _$Post {
  const factory Post({required int id, required String title}) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
```

Genera: `copyWith`, `==`/`hashCode` (comparación por valor), `toString()`, `fromJson`/`toJson`.

Inmutable = no puedes hacer `post.title = 'x'`. Para "cambiar" algo:

```dart
state = state.copyWith(title: 'nuevo');   // crea copia nueva -> Riverpod detecta el cambio y repinta
```

Mutar directo NO dispararía repintado. La inmutabilidad no es manía: es lo que hace funcionar la detección de cambios.

### AsyncValue (loading / data / error)

Para cualquier dato que venga de red/DB: haz el `build()` del Notifier **async**. Riverpod lo envuelve solo en `AsyncValue<T>`:

```dart
@riverpod
class Posts extends _$Posts {
  @override
  Future<List<Post>> build() => ref.watch(postsRepositoryProvider).fetchPosts();
  // corre -> AsyncLoading | retorna -> AsyncData | lanza excepción -> AsyncError
}
```

En el widget, `.when` obliga a cubrir los 3 casos:

```dart
ref.watch(postsProvider).when(
  loading: () => const CircularProgressIndicator(),
  data: (posts) => ListView(...),
  error: (err, stack) => Text(err is ApiException ? err.message : 'Error'),
)
```

Refrescar/reintentar: `ref.invalidateSelf()` dentro del Notifier re-ejecuta `build()` de cero (ver `refresh()` en `posts_provider.dart`).

**NO crees sealed classes manuales para loading/error genérico** — AsyncValue ya lo es.

### Sealed classes (cuándo sí)

Para estados de negocio con más matices que loading/data/error. Ejemplo vivo: `ApiException` en `core/api/api_exception.dart`. `sealed` = el compilador conoce todos los subtipos → un `switch` sin algún caso es error de compilación, no bug en runtime.

```dart
final mensaje = switch (error) {
  NetworkException() => 'Sin conexión',
  UnauthorizedException() => 'Sesión expirada',
  ServerException(:final statusCode) => 'Error $statusCode',  // destructuring de campos
  NotFoundException() => 'No encontrado',
  UnknownApiException() => 'Error inesperado',
};
```

Otro caso típico: formularios (`Idle / Validating / Submitting / Success / ValidationError`).

### go_router

Rutas en `router.dart`. Añadir pantalla = añadir `GoRoute`:

```dart
GoRoute(path: '/detalle', builder: (context, state) => const DetalleScreen()),
```

Navegar desde cualquier widget:

- `context.go('/detalle')` → **reemplaza** la ruta actual (sin botón atrás)
- `context.push('/detalle')` → **apila** (con botón atrás)

Parámetros: `GoRoute(path: '/user/:id', ...)` → `state.pathParameters['id']`.

**Bottom nav (tabs):** montado con `StatefulShellRoute.indexedStack` en `router.dart` + `core/navigation/app_shell.dart`. Cada tab = una `StatefulShellBranch` con sus rutas; el estado/historial de cada tab se conserva al cambiar. Añadir tab = nueva branch en `router.dart` + nueva `NavigationDestination` en `app_shell.dart` (mismo orden). Pantallas sin bottom nav (login, detalle fullscreen): `GoRoute` al mismo nivel que el shell, fuera de él.

---

## Capa de API

Flujo: **Screen → Provider → Repository → Dio**. Los widgets/providers nunca tocan dio directo.

- `core/api/api_client.dart` — Dio único para toda la app (`apiClientProvider`): baseUrl desde `.env`, timeouts, interceptor de auth (inyecta `Bearer <token>` automático si hay token guardado; en 401 lo borra), logging solo en debug.
- `core/api/api_exception.dart` — errores tipados con mensajes de usuario. Los repositorios convierten `DioException` → `ApiException`.
- `core/storage/secure_storage.dart` — tras el login: `ref.read(tokenStorageProvider).save(token)`. A partir de ahí todas las requests van autenticadas solas.

### Añadir un endpoint nuevo (patrón repositorio)

```dart
@Riverpod(keepAlive: true)
UsersRepository usersRepository(Ref ref) => UsersRepository(ref.watch(apiClientProvider));

class UsersRepository {
  const UsersRepository(this._dio);
  final Dio _dio;

  Future<User> fetchUser(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/users/$id');
      return User.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);   // SIEMPRE: error crudo -> error tipado
    }
  }
}
```

---

## Variables de entorno (envied)

Se leen de `.env` **en compile-time** y quedan ofuscadas en el binario. `.env` está gitignored; `.env.example` se commitea como plantilla.

Añadir una variable (3 pasos):

1. `.env` y `.env.example`: `MI_VARIABLE=valor`
2. `core/env/env.dart`:
   ```dart
   @EnviedField(varName: 'MI_VARIABLE')
   static final String miVariable = _Env.miVariable;
   ```
3. `dart run build_runner build`

Uso: `Env.miVariable`. Ojo: al cambiar `.env` hay que regenerar (compile-time, no runtime).

---

## Crear una feature nueva (checklist)

Usa `features/example/` como referencia copy-paste.

1. Carpeta `lib/features/mi_feature/` con `domain/`, `data/`, `presentation/`
2. `domain/mi_modelo.dart` — modelo freezed, copia el patrón de `post.dart`
3. `data/mi_repository.dart` — si hay API, copia `posts_repository.dart`
4. `presentation/mi_provider.dart` — `build()` async si carga datos (AsyncValue gratis)
5. `presentation/mi_screen.dart` — `ConsumerWidget` + `.when` si es async
6. Ruta en `router.dart`
7. `dart run build_runner build`
8. `flutter analyze && flutter test`

## Testing

Patrón clave (ver `test/widget_test.dart`): **overrides de ProviderScope** — sustituyes el repositorio real por un fake para no tocar red en tests:

```dart
ProviderScope(
  overrides: [postsRepositoryProvider.overrideWithValue(_FakePostsRepository())],
  child: const MyApp(),
)
```

Cualquier provider es sustituible así: esa es la razón de inyectar todo vía providers.

---

## Errores comunes

| Síntoma                                 | Causa / solución                                                          |
| --------------------------------------- | ------------------------------------------------------------------------- |
| `Undefined name 'xxxProvider'`          | Falta `dart run build_runner build`                                       |
| Codegen no regenera                     | `dart run build_runner clean` y volver a build                            |
| Cambié `.env` y no se aplica            | Envied es compile-time: regenerar con build_runner                        |
| Widget no repinta al cambiar estado     | ¿Mutaste en vez de `copyWith`? ¿Usaste `read` en build en vez de `watch`? |
| `No ProviderScope found`                | Falta `ProviderScope` en la raíz (main.dart)                              |
| Test falla con "Timer is still pending" | El test tocó red: overridea el repositorio con un fake                    |
