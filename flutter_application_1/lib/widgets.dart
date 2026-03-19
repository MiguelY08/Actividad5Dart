/// widgets.dart
/// ─────────────────────────────────────────────────────────────────────────────
/// Todos los widgets reutilizables de la app agrupados en un solo archivo.
///
/// Widgets incluidos:
///   • HeaderBar         → Avatar + nombre de tienda + íconos de acción
///   • BudgetCard        → Tarjeta azul con presupuesto total + filas
///   • BudgetRowWidget   → Fila individual de ingreso o gasto
///   • TabSelector       → Pestañas "Categories" / "Recent transaction"
///   • CategoryCard      → Tarjeta de categoría con emoji, montos y badge
/// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'constant.dart';
import 'models.dart';

// ══════════════════════════════════════════════════════════════════════════════
// HEADER BAR
// Barra superior: avatar | nombre de tienda | notificación | menú
// ══════════════════════════════════════════════════════════════════════════════
class HeaderBar extends StatelessWidget {
  final String storeName;

  const HeaderBar({super.key, this.storeName = 'Store Name'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Avatar circular con imagen de red
          CircleAvatar(
            radius: 22,
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=47'),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(width: 10),

          // Nombre de la tienda
          Text(
            storeName,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),

          // Ícono de notificaciones con badge rojo (unread)
          // Stack permite superponer el punto rojo encima del ícono
          Stack(
            clipBehavior: Clip.none,
            children: [
              _IconButton(icon: Icons.notifications_none_rounded),
              Positioned(
                top: -3,
                right: -3,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          // Ícono de menú (more_vert)
          _IconButton(icon: Icons.more_vert_rounded),
        ],
      ),
    );
  }
}

/// Botón de ícono con borde redondeado — reutilizado en el HeaderBar
class _IconButton extends StatelessWidget {
  final IconData icon;
  const _IconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 22, color: AppColors.textDark),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// BUDGET ROW WIDGET
// Fila de ingreso o gasto dentro de la tarjeta azul.
// [Ícono] [Etiqueta] ───── [Monto] [Fecha] [→]
// ══════════════════════════════════════════════════════════════════════════════
class BudgetRowWidget extends StatelessWidget {
  final BudgetRowModel data;

  const BudgetRowWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15), // Blanco translúcido sobre el azul
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Burbuja blanca con ícono de dirección
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.iconColor, size: 22),
          ),
          const SizedBox(width: 12),

          // Etiqueta: "Incomes" o "Spending"
          Text(
            data.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),

          // Monto + rango de fechas alineados a la derecha
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data.amount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 2),
              Text(data.dateRange,
                  style: const TextStyle(color: Colors.white60, fontSize: 10)),
            ],
          ),
          const SizedBox(width: 10),

          // Botón flecha derecha (keyboard_arrow_right)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// BUDGET CARD
// Tarjeta blanca que contiene el HeaderBar + la sección azul con el presupuesto.
// Recibe los modelos de ingreso y gasto para renderizar las filas.
// ══════════════════════════════════════════════════════════════════════════════
class BudgetCard extends StatelessWidget {
  final String         totalBudget;  // "2.868.000"
  final BudgetRowModel incomeData;
  final BudgetRowModel spendingData;

  const BudgetCard({
    super.key,
    required this.totalBudget,
    required this.incomeData,
    required this.spendingData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Parte blanca: encabezado
          const HeaderBar(),

          // Parte azul: monto total + filas de ingreso/gasto
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Etiqueta pequeña
                const Text(
                  'Your budget',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 6),

                // Monto en grande — RichText combina 3 estilos distintos en una línea
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: '\$ ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: totalBudget,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5),
                    ),
                    const TextSpan(
                      text: ',00',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                ),
                const SizedBox(height: 24),

                // Fila de ingresos
                BudgetRowWidget(data: incomeData),
                const SizedBox(height: 12),

                // Fila de gastos
                BudgetRowWidget(data: spendingData),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB SELECTOR
// Pestañas animadas: "Categories" | "Recent transaction"
// Es StatefulWidget porque necesita recordar cuál tab está activo.
// ══════════════════════════════════════════════════════════════════════════════
class TabSelector extends StatefulWidget {
  final List<String>           tabs;
  final void Function(int)?    onTabChanged; // Callback al padre cuando cambia el tab

  const TabSelector({
    super.key,
    required this.tabs,
    this.onTabChanged,
  });

  @override
  State<TabSelector> createState() => _TabSelectorState();
}

class _TabSelectorState extends State<TabSelector> {
  int _selectedIndex = 0; // Tab activo, comienza en 0 (Categories)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // Generamos un botón por cada tab de la lista
        child: Row(
          children: List.generate(
            widget.tabs.length,
            (index) => _buildTab(index),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedIndex = index);
          widget.onTabChanged?.call(index); // Notifica al padre (si hay callback)
        },
        child: AnimatedContainer(
          // AnimatedContainer anima suavemente los cambios de decoración
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2))]
                : [],
          ),
          child: Text(
            widget.tabs[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? AppColors.textDark : Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CATEGORY CARD
// Tarjeta de categoría: [Emoji] [Título + hoy + total] [Badge %]
// ══════════════════════════════════════════════════════════════════════════════
class CategoryCard extends StatelessWidget {
  final CategoryModel data;

  const CategoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Cuadrado con emoji de la categoría
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: data.emojiBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(data.emoji, style: const TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(width: 14),

          // Columna: título, movimiento del día, total
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark)),
                const SizedBox(height: 3),
                Text(data.todayAmount,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                const SizedBox(height: 3),
                Text(data.total,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark)),
              ],
            ),
          ),

          // Badge de porcentaje — color cambia según data.isUp
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: data.isUp ? AppColors.badgeUpBg : AppColors.badgeDownBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data.percent,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: data.isUp ? AppColors.badgeUpText : AppColors.badgeDownText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}