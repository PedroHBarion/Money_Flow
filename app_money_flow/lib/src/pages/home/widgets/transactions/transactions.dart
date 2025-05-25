// transactions.dart
import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import 'package:app_money_flow/src/core/utils/format_date.dart';
import 'package:app_money_flow/src/widgets/modals/TransactionModal/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import './transactions_controller.dart';
import '../../../../widgets/dropdown_transaction.dart';
import '../../../../widgets/filter_modal.dart';
import '../../../../widgets/custom_month_navigation.dart';
import '../../../../widgets/transaction_card.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  void initState() {
    super.initState();

    // Aguarda o build inicial antes de fazer o fetch
    Future.microtask(() {
      final controller = context.read<TransactionsController>();
      controller.currentMonthIndex = DateTime.now().month - 1;
      controller.fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionsController>();

    void handleOpenTransactionModal(
        {required TransactionType typeModal,
        required TransactionModel transaction}) {
      showDialog(
        context: context,
        builder: (_) => TransactionModal(
          type: typeModal,
          transaction: transaction,
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DropdownTransaction(),
                IconButton(
                  onPressed: () => _openFilterModal(context, controller),
                  icon: SvgPicture.asset('assets/icons/filter_icon.svg'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Mês
            CustomMonthNavigation(
              currentMonthIndex: controller.currentMonthIndex,
              onMonthChanged: controller.changeMonth,
            ),
            const SizedBox(height: 10),

            // Estado de loading
            if (controller.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (controller.transactions.isEmpty)
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Image.asset('assets/images/empty_state.png'),
                    Text(
                      'Você ainda não cadastrou nada, \nvocê pode começar por suas contas,\n depois receitas e despesas :)',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            else
              ...controller.transactions.map((tx) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TransactionCard(
                      type: tx.type,
                      icon: tx.category?.icon,
                      title: tx.name,
                      date: formatDate(tx.date),
                      amount: tx.value,
                      onTap: () => handleOpenTransactionModal(
                          typeModal: tx.type, transaction: tx),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  void _openFilterModal(
      BuildContext context, TransactionsController controller) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return FilterModal(
          onTempAccountChanged: controller.setTempAccount,
          onTempYearChanged: controller.setTempYear,
          onApplyFilters: controller.applyFilters,
          onClearFilters: controller.clearFilters,
        );
      },
    );
  }
}
