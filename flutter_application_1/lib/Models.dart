/// models.dart
/// ─────────────────────────────────────────────────────────────────────────────
/// Todos los modelos de datos de la app.
/// Un modelo es una clase que solo guarda información, sin lógica de UI.
/// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

// ─── Modelo para las filas de Ingreso / Gasto ─────────────────────────────────
class BudgetRowModel {
  final IconData icon;      // Ícono (flecha arriba o abajo)
  final Color    iconColor; // Verde para ingresos, rojo para gastos
  final String   label;     // "Incomes" o "Spending"
  final String   amount;    // Monto formateado: "$ 700.000,00"
  final String   dateRange; // Rango de fechas del período

  const BudgetRowModel({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.amount,
    required this.dateRange,
  });
}

// ─── Modelo para las tarjetas de Categoría ────────────────────────────────────
class CategoryModel {
  final String emoji;           // Emoji representativo: 🍕 🖥️ 🫧
  final Color  emojiBackground; // Color de fondo detrás del emoji
  final String title;           // Nombre: "Food & Drink", "Electronics"…
  final String todayAmount;     // Movimiento del día: "+ $ 2250 Today"
  final String total;           // Total acumulado: "$ 391.254,01"
  final String percent;         // Cambio porcentual: "↑ 1.8 %" o "↓ 25.8 %"
  final bool   isUp;            // true = verde (sube), false = rojo (baja)

  const CategoryModel({
    required this.emoji,
    required this.emojiBackground,
    required this.title,
    required this.todayAmount,
    required this.total,
    required this.percent,
    required this.isUp,
  });
}