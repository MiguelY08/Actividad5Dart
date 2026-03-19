/// constants.dart
/// ─────────────────────────────────────────────────────────────────────────────
/// Todos los colores globales de la app en un solo archivo.
/// Si necesitas cambiar un color, solo lo tocas aquí.
/// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Constructor privado: no se instancia, solo se usan sus valores

  static const Color primary        = Color(0xFF3D5AFE); // Azul principal
  static const Color background     = Color(0xFFF0F2F8); // Fondo gris claro
  static const Color textDark       = Color(0xFF1A1A2E); // Texto oscuro

  static const Color income         = Color(0xFF4CAF50); // Verde ingresos
  static const Color spending       = Color(0xFFF44336); // Rojo gastos

  static const Color badgeUpBg      = Color(0xFFE8F5E9); // Badge verde fondo
  static const Color badgeUpText    = Color(0xFF388E3C); // Badge verde texto
  static const Color badgeDownBg    = Color(0xFFFFEBEE); // Badge rojo fondo
  static const Color badgeDownText  = Color(0xFFD32F2F); // Badge rojo texto

  static const Color categoryFoodBg   = Color(0xFFFFF3E0); // Fondo emoji comida
  static const Color categoryElecBg   = Color(0xFFE8EAF6); // Fondo emoji electrónica
  static const Color categoryHealthBg = Color(0xFFE3F2FD); // Fondo emoji salud
}