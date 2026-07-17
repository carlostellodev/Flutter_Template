import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

/// Storage cifrado del sistema (Keychain en iOS, Keystore en Android...).
/// Para datos sensibles: tokens, credenciales. NO para preferencias normales.
@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) => const FlutterSecureStorage();

/// Helpers para el token de sesión. Úsalo desde el login:
/// `ref.read(tokenStorageProvider).save(tokenRecibido)`.
@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) =>
    TokenStorage(ref.watch(secureStorageProvider));

class TokenStorage {
  const TokenStorage(this._storage);

  static const _key = 'auth_token';
  final FlutterSecureStorage _storage;

  Future<String?> read() => _storage.read(key: _key);

  Future<void> save(String token) => _storage.write(key: _key, value: token);

  Future<void> delete() => _storage.delete(key: _key);
}
