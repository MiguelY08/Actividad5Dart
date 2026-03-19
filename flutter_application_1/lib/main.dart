
/// ─────────────────────────────────────────────────────────────────────────────
/// Punto de entrada de la app. Flutter siempre busca main() para arrancar.
///
/// Estructura del proyecto (solo 4 archivos + main):
///   lib/
///   ├── main.dart           ← Arranca la app, configura tema global
///   ├── constants.dart      ← Todos los colores en un lugar
///   ├── models.dart         ← Clases de datos (BudgetRowModel, CategoryModel)
///   ├── widgets.dart        ← Todos los widgets reutilizables
///   └── budget_screen.dart  ← Pantalla principal, ensambla todo
/// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'budgetScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF0F2F8),
        useMaterial3: true,
      ),
      home: const BudgetScreen(),
    );
  }
}