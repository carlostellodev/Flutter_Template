import 'package:dio/dio.dart';

/// Errores tipados de la API. `sealed` = el compilador obliga a cubrir
/// todos los casos en un `switch` (imposible olvidar uno).
///
/// Uso en repositorios:
/// ```dart
/// try {
///   final response = await dio.get<...>('/endpoint');
/// } on DioException catch (e) {
///   throw ApiException.fromDioException(e);
/// }
/// ```
sealed class ApiException implements Exception {
  const ApiException();

  /// Mapea automáticamente un [DioException] al subtipo correcto.
  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        // Muchas APIs devuelven {"message": "..."} en errores: lo leemos.
        final data = e.response?.data;
        final serverMessage =
            (data is Map<String, dynamic>) ? data['message'] as String? : null;
        return switch (status) {
          401 => const UnauthorizedException(),
          404 => const NotFoundException(),
          >= 500 => ServerException(statusCode: status, detail: serverMessage),
          _ => UnknownApiException(detail: serverMessage ?? e.message),
        };
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return UnknownApiException(detail: e.message);
    }
  }

  /// Mensaje legible para mostrar al usuario.
  String get message;
}

/// Sin conexión o timeout.
final class NetworkException extends ApiException {
  const NetworkException();

  @override
  String get message =>
      'No hay conexión con el servidor. Comprueba tu red e inténtalo de nuevo.';
}

/// 401 — token inválido o sesión expirada.
final class UnauthorizedException extends ApiException {
  const UnauthorizedException();

  @override
  String get message => 'Tu sesión ha expirado. Vuelve a iniciar sesión.';
}

/// 404 — recurso no encontrado.
final class NotFoundException extends ApiException {
  const NotFoundException();

  @override
  String get message => 'No se ha encontrado el recurso solicitado.';
}

/// 5xx — error del servidor.
final class ServerException extends ApiException {
  const ServerException({required this.statusCode, this.detail});

  final int statusCode;
  final String? detail;

  @override
  String get message =>
      detail ?? 'Error del servidor ($statusCode). Inténtalo más tarde.';
}

/// Cualquier otro error no contemplado.
final class UnknownApiException extends ApiException {
  const UnknownApiException({this.detail});

  final String? detail;

  @override
  String get message => detail ?? 'Ha ocurrido un error inesperado.';
}
