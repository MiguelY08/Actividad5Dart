/// budget_screen.dart
/// ─────────────────────────────────────────────────────────────────────────────
/// Pantalla principal. Solo ensambla los widgets y provee los datos.
/// No tiene lógica de UI propia: cada pieza visual ya está en widgets.dart.
/// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'constant.dart';
import 'models.dart';
import 'widgets.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  // ─── Datos de ingreso y gasto ─────────────────────────────────────────────
  // static const = se crean una sola vez y se reutilizan (no se recrean en cada build)
  static const _income = BudgetRowModel(
    icon: Icons.arrow_upward_rounded,
    iconColor: AppColors.income,
    label: 'Incomes',
    amount: '\$ 700.000,00',
    dateRange: 'From January 1 to January 31',
  );

  static const _spending = BudgetRowModel(
    icon: Icons.keyboard_arrow_down_rounded,
    iconColor: AppColors.spending,
    label: 'Spending',
    amount: '\$ 90.000,00',
    dateRange: 'From January 1 to January 31',
  );

  // ─── Lista de categorías ──────────────────────────────────────────────────
  static const _categories = [
    CategoryModel(
      emoji: '🍕',
      emojiBackground: AppColors.categoryFoodBg,
      title: 'Food & Drink',
      todayAmount: '+ \$ 2250 Today',
      total: '\$ 391.254,01',
      percent: '↑ 1.8 %',
      isUp: true,
    ),
    CategoryModel(
      emoji: '🖥️',
      emojiBackground: AppColors.categoryElecBg,
      title: 'Electronics',
      todayAmount: '+ \$ 2250 Today',
      total: '\$ 3.176.254,01',
      percent: '↑ 43.6 %',
      isUp: true,
    ),
    CategoryModel(
      emoji: '🫧',
      emojiBackground: AppColors.categoryHealthBg,
      title: 'Health',
      todayAmount: '+ \$ 110 Today',
      total: '\$ 38,01',
      percent: '↓ 25.8 %',
      isUp: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        // SafeArea evita que el contenido quede bajo el notch o la barra de estado
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Tarjeta azul de presupuesto
              BudgetCard(
                totalBudget: '2.868.000',
                incomeData: _income,
                spendingData: _spending,
              ),

              // 2. Pestañas
              TabSelector(
                tabs: const ['Categories', 'Recent transaction'],
                onTabChanged: (index) {
                  // TODO: cambiar contenido según el tab seleccionado
                  debugPrint('Tab: $index');
                },
              ),

              const SizedBox(height: 16),

              // 3. Enlace "View All"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'View All',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 4. Lista de categorías
              // shrinkWrap + NeverScrollableScrollPhysics porque ya estamos
              // dentro de un SingleChildScrollView
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                itemBuilder: (_, index) =>
                    CategoryCard(data: _categories[index]),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}