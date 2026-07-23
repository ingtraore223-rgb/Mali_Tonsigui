import 'package:flutter/material.dart';

/// Couleurs du drapeau du Mali, utilisées pour le logo de l'application.
class MaliFlagColors {
  static const green = Color(0xFF14A64C);
  static const yellow = Color(0xFFFCD116);
  static const red = Color(0xFFCE1126);
}

/// Palette "captivante" de l'interface : doré chaud pour les actions
/// principales, corail pour l'action de tirage, vert pour les paiements
/// confirmés, ambre pour les paiements en attente.
class AppColors {
  // Fond et surfaces
  static const pageBackground = Color(0xFFF6F3ED);
  static const cardBackground = Color(0xFFFFFFFF);
  static const border = Color(0xFFE7E2D6);

  // Texte
  static const textPrimary = Color(0xFF2A2118);
  static const textSecondary = Color(0xFF6B6459);
  static const textMuted = Color(0xFF9B9384);

  // Doré (accent principal)
  static const goldBg = Color(0xFFFAEEDA);
  static const goldText = Color(0xFF633806);
  static const goldStrong = Color(0xFFBA7517);
  static const goldDark = Color(0xFF412402);

  // Corail (action de tirage / mise en avant)
  static const coralBg = Color(0xFFFAECE7);
  static const coralBorder = Color(0xFFF0997B);
  static const coralText = Color(0xFF712B13);
  static const coralStrong = Color(0xFFD85A30);
  static const coralDark = Color(0xFF4A1B0C);

  // Vert (paiement confirmé)
  static const greenText = Color(0xFF3B6D11);
  static const greenBar = Color(0xFF639922);

  // Ambre (en attente)
  static const amberText = Color(0xFF854F0B);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.pageBackground,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.goldStrong,
      primary: AppColors.goldStrong,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textPrimary),
    ),
  );
}
