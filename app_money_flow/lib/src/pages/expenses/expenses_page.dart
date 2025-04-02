import 'package:app_money_flow/src/core/controller/expense_controller.dart';
import 'package:app_money_flow/src/widgets/balance_card.dart';
import 'package:app_money_flow/src/widgets/custom_month_navigation.dart';
import 'package:app_money_flow/src/widgets/savings_suggestion_card.dart';
import 'package:app_money_flow/src/widgets/custom_app_bar.dart';
import 'package:app_money_flow/src/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpensesController(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Consumer<ExpensesController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Column(
                  children: [
                    CustomMonthNavigation(
                      currentMonthIndex: controller.currentMonthIndex,
                      onMonthChanged: (newIndex) {
                        controller.updateMonth(newIndex);
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BalanceCard(
                          title: "Saldo atual total",
                          subTitle: "R\$: 59,45",
                          subTitlecolor: Color(0xFFFFFFFF),
                          titleColor: Color(0xFFFFFFFF),
                          background: Color(0xFF087F5B),
                        ),
                        BalanceCard(
                          title: "Gastos Previstos",
                          subTitle:
                              "R\$ ${controller.totalExpenses(controller.currentMonthIndex + 1)}",

                          subTitlecolor: Color(0xFF087F5B),
                          titleColor: Color.fromARGB(255, 0, 0, 0),
                          background: Color(0xFFFFFFFF),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: controller.chartData,
                          centerSpaceRadius: 50,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (controller.transactions.isNotEmpty)
                      TransactionCard(
                        iconPath: 'assets/icons/shopping_cart.svg',
                        color: 0xFFFFFFFF,
                        title: "Principal Gasto",
                        date:
                            controller
                                .getHighestTransactionForMonth(
                                  controller.currentMonthIndex,
                                )
                                ?.category ??
                            "N/A",
                        amount:
                            controller.getHighestTransactionForMonth(
                                      controller.currentMonthIndex,
                                    ) !=
                                    null
                                ? "-R\$ ${controller.getHighestTransactionForMonth(controller.currentMonthIndex)!.value.toStringAsFixed(2)}"
                                : "-R\$ 0,00",
                      ),

                    const SavingsSuggestionCard(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
