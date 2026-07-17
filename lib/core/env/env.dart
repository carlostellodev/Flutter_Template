import 'package:envied/envied.dart';

part 'env.g.dart';

/// Variables de entorno type-safe, leídas de `.env` EN COMPILE-TIME.
///
/// Para añadir una variable nueva:
/// 1. Añádela en `.env` y `.env.example`
/// 2. Añade el campo aquí con `@EnviedField`
/// 3. Corre `dart run build_runner build`
@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL')
  static final String apiBaseUrl = _Env.apiBaseUrl;
}
