import 'package:flutter/material.dart';

/// Tema centralizado. Cambia [_seedColor] para re-tematizar toda la app.
abstract final class AppTheme {
  static const MaterialColor _seedColor = Colors.deepOrange;

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
  );

  static ThemeData get dark => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
  );
}
