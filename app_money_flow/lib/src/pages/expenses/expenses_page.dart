import 'package:app_money_flow/src/core/utils/format_currency.dart';
import 'package:app_money_flow/src/pages/expenses/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:app_money_flow/src/pages/expenses/expense_controller.dart';
import 'package:app_money_flow/src/core/enums/transaction_type.dart';

import 'package:app_money_flow/src/widgets/app_bar.dart';
import 'package:app_money_flow/src/widgets/balance_card.dart';
import 'package:app_money_flow/src/widgets/transaction_card.dart';
import 'package:app_money_flow/src/pages/expenses/widgets/savings_suggestion_card.dart';
import 'package:app_money_flow/src/widgets/custom_month_navigation.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  late ExpensesController controller;

  @override
  void initState() {
    super.initState();
    // Pega o controller do Provider depois do build (via addPostFrameCallback)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = Provider.of<ExpensesController>(context, listen: false);
      fetchExpenses();
    });
  }

  Future<void> fetchExpenses() async {
    await controller.loadTransactions();
    await controller.loadTransactionByCategory();
    // Se precisar carregar outras coisas, chama aqui também
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Consumer<ExpensesController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Column(
                children: [
                  CustomMonthNavigation(
                    currentMonthIndex: controller.currentMonthIndex,
                    onMonthChanged: (newIndex) {
                      controller.changeMonth(newIndex);
                      fetchExpenses();
                    },
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BalanceCard(
                        title: "Saldo atual total",
                        subTitle:
                            'R\$ ${formatCurrency(controller.getTotalBalance())}',
                        subTitlecolor: const Color(0xFFFFFFFF),
                        titleColor: const Color(0xFFFFFFFF),
                        background: const Color(0xFF087F5B),
                      ),
                      BalanceCard(
                        title: "Gastos Previstos",
                        subTitle:
                            "R\$ ${formatCurrency(controller.totalExpenses())}",
                        subTitlecolor: const Color(0xFF087F5B),
                        titleColor: Colors.black,
                        background: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Pie Chart ou estado vazio
                  SizedBox(
                    height: 250,
                    child: controller.chartData.isEmpty
                        ? const EmptyStateWidget(
                            icon: Icons.pie_chart,
                            message: 'Nenhum gasto por categoria neste mês.',
                          )
                        : PieChart(
                            PieChartData(
                              sections: controller.chartData,
                              centerSpaceRadius: 50,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Maior gasto do mês ou estado vazio
                  if (controller.transactions.isNotEmpty) ...[
                    (() {
                      final highestTransaction =
                          controller.getHighestTransactionForMonth();

                      return TransactionCard(
                        icon: 'home',
                        type: TransactionType.expense,
                        title: "Principal Gasto",
                        date: highestTransaction?.category?.name ?? "N/A",
                        amount: highestTransaction?.value ?? 0.0,
                      );
                    })(),
                  ] else ...[
                    const EmptyStateWidget(
                      icon: Icons.trending_down,
                      message: 'Nenhum gasto registrado neste mês.',
                    ),
                  ],

                  const SizedBox(height: 20),
                  if (controller.categoryMessage != null)
                    SavingsSuggestionCard(date: controller.categoryMessage!),

                  const SizedBox(height: 55),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
