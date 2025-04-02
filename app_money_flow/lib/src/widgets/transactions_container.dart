import 'package:app_money_flow/src/widgets/dropdown_transaction.dart';
import 'package:app_money_flow/src/widgets/filter_modal.dart';
import 'package:app_money_flow/src/widgets/custom_month_navigation.dart';
import 'package:app_money_flow/src/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionsContainer extends StatefulWidget {
  const TransactionsContainer({super.key});

  @override
  State<TransactionsContainer> createState() => _TransactionsContainerState();
}

class _TransactionsContainerState extends State<TransactionsContainer> {
  String? selectedAccount;
  int? selectedYear;

  int currentMonthIndex = 0; // Exemplo de índice de mês selecionado

  void changeMonth(int direction) {
    setState(() {
      currentMonthIndex = (currentMonthIndex + direction) % 12;
    });
  }

  void _openFilterModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return FilterModal(
          onAccountSelected: (account) {
            setState(() => selectedAccount = account);
          },
          onYearSelected: (year) {
            setState(() => selectedYear = year);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Color(0xFFF1F3F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownTransaction(),
              IconButton(
                onPressed: _openFilterModal,
                icon: SvgPicture.asset('assets/icons/filter_icon.svg'),
              ),
            ],
          ),
          SizedBox(height: 20),
          CustomMonthNavigation(
            currentMonthIndex: currentMonthIndex,
            onMonthChanged: changeMonth,
          ),

          SizedBox(height: 10),

          Column(
            children: [
              TransactionCard(
                color: 0xFFEBFBEE,
                iconPath: 'assets/icons/transaction_icon.svg',
                title: "Almoço",
                date: "02/20/06",
                amount: "-R\$ 693,00",
              ),
              TransactionCard(
                color: 0xFFEBFBEE,
                iconPath: 'assets/icons/transaction_icon.svg',
                title: "Almoço",
                date: "Roupas",
                amount: "-R\$ 693,00",
              ),
              TransactionCard(
                color: 0xFFEBFBEE,
                iconPath: 'assets/icons/transaction_icon.svg',
                title: "Almoço",
                date: "Roupas",
                amount: "-R\$ 693,00",
              ),
              TransactionCard(
                color: 0xFFEBFBEE,
                iconPath: 'assets/icons/transaction_icon.svg',
                title: "Almoço",
                date: "02/20/06",
                amount: "-R\$ 693,00",
              ),
              TransactionCard(
                color: 0xFFEBFBEE,
                iconPath: 'assets/icons/transaction_icon.svg',
                title: "Almoço",
                date: "Roupas",
                amount: "-R\$ 693,00",
              ),
              TransactionCard(
                color: 0xFFEBFBEE,
                iconPath: 'assets/icons/transaction_icon.svg',
                title: "Almoço",
                date: "Roupas",
                amount: "-R\$ 693,00",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
