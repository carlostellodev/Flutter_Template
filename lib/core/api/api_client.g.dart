// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Cliente HTTP central. Todos los repositorios lo usan vía
/// `ref.watch(apiClientProvider)`. Nunca crees `Dio()` sueltos.

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

/// Cliente HTTP central. Todos los repositorios lo usan vía
/// `ref.watch(apiClientProvider)`. Nunca crees `Dio()` sueltos.

final class ApiClientProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Cliente HTTP central. Todos los repositorios lo usan vía
  /// `ref.watch(apiClientProvider)`. Nunca crees `Dio()` sueltos.
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$apiClientHash() => r'14c2ea8176b63a7793d9f64050295511ba82fd5a';
