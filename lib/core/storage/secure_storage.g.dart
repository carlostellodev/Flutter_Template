// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Storage cifrado del sistema (Keychain en iOS, Keystore en Android...).
/// Para datos sensibles: tokens, credenciales. NO para preferencias normales.

@ProviderFor(secureStorage)
final secureStorageProvider = SecureStorageProvider._();

/// Storage cifrado del sistema (Keychain en iOS, Keystore en Android...).
/// Para datos sensibles: tokens, credenciales. NO para preferencias normales.

final class SecureStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorage,
          FlutterSecureStorage,
          FlutterSecureStorage
        >
    with $Provider<FlutterSecureStorage> {
  /// Storage cifrado del sistema (Keychain en iOS, Keystore en Android...).
  /// Para datos sensibles: tokens, credenciales. NO para preferencias normales.
  SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return secureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$secureStorageHash() => r'0cd1b80f91784467390034386f925a0be155bfbd';

/// Helpers para el token de sesión. Úsalo desde el login:
/// `ref.read(tokenStorageProvider).save(tokenRecibido)`.

@ProviderFor(tokenStorage)
final tokenStorageProvider = TokenStorageProvider._();

/// Helpers para el token de sesión. Úsalo desde el login:
/// `ref.read(tokenStorageProvider).save(tokenRecibido)`.

final class TokenStorageProvider
    extends $FunctionalProvider<TokenStorage, TokenStorage, TokenStorage>
    with $Provider<TokenStorage> {
  /// Helpers para el token de sesión. Úsalo desde el login:
  /// `ref.read(tokenStorageProvider).save(tokenRecibido)`.
  TokenStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStorageHash();

  @$internal
  @override
  $ProviderElement<TokenStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenStorage create(Ref ref) {
    return tokenStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenStorage>(value),
    );
  }
}

String _$tokenStorageHash() => r'343a4777583de23577989070e81a30ae661cd151';
