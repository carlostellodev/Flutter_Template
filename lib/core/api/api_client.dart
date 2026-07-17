import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/core/env/env.dart';
import 'package:my_app/core/storage/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

/// Cliente HTTP central. Todos los repositorios lo usan vía
/// `ref.watch(apiClientProvider)`. Nunca crees `Dio()` sueltos.
@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  final tokenStorage = ref.watch(tokenStorageProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      // Antes de cada request: inyecta el Bearer token si existe.
      onRequest: (options, handler) async {
        final token = await tokenStorage.read();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      // En 401: token inválido -> lo borramos.
      // Aquí puedes añadir lógica de refresh-token o redirigir a login.
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await tokenStorage.delete();
        }
        handler.next(error);
      },
    ),
  );

  // Log de requests/responses solo en debug (nunca en release).
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  return dio;
}
