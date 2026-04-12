import 'package:flutter/material.dart';

// Tema estritamente Preto e Branco (Black & White Theme)
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,

      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),

      // Barra superior limpa e preta
      appBarTheme: const AppBarThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // Campos de texto com bordas simples
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black54),
        hintStyle: TextStyle(color: Colors.black38),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),

      // Botão preto sólido
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}