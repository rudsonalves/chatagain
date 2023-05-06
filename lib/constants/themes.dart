import 'package:flutter/material.dart';

part './color_schemes.g.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      appBarTheme: const AppBarTheme(
        // backgroundColor: _lightColorScheme.primary,
        // foregroundColor: _lightColorScheme.onPrimary,
        centerTitle: true,
      ),
    );

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      appBarTheme: const AppBarTheme(
        // backgroundColor: _darkColorScheme.primary,
        // foregroundColor: _darkColorScheme.onPrimary,
        centerTitle: true,
      ),
    );

List<Color> greenGradient = [
  _lightColorScheme.primary,
  _darkColorScheme.primary,
];
