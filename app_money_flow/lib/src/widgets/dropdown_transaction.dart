import 'package:app_money_flow/src/core/config/locator.dart';
import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pages/home/widgets/transactions/transactions_controller.dart';


class DropdownTransaction extends StatefulWidget {
  const DropdownTransaction({super.key});

  @override
  _DropdownTransactionState createState() => _DropdownTransactionState();
}

class _DropdownTransactionState extends State<DropdownTransaction> {
  String selectedValue = 'Transações';

  void handleTransactionTypeChange(String? newValue) {
    if (newValue == null) return;

    setState(() {
      selectedValue = newValue;
    });

    final controller = getIt<TransactionsController>();

    final selectedOption = options.firstWhere((opt) => opt['label'] == newValue);
    final TransactionType? type = selectedOption['value'];

    controller.setTransactionType(type);
  }

  final List<Map<String, dynamic>> options = [
  {
    'label': 'Receitas',
    'color': const Color(0xFFEBFBEE),
    'icon': 'assets/icons/income_icon.svg',
    'value': TransactionType.income,
  },
  {
    'label': 'Despesas',
    'color': const Color(0xFFFFF5F5),
    'icon': 'assets/icons/expense_icon.svg',
    'value': TransactionType.expense,
  },
  {
    'label': 'Transações',
    'color': const Color(0xFFEDF2FF),
    'icon': 'assets/icons/bank_icon.svg',
    'value': null,
  },
];


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(16),
        value: selectedValue,
        style: TextStyle(color: Colors.black, fontSize: 16),
        onChanged: handleTransactionTypeChange,
        items: options.map<DropdownMenuItem<String>>((option) {
          return DropdownMenuItem<String>(
            value: option['label'],
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: option['color'],
                  radius: 16,
                  child:  SvgPicture.asset(option['icon']),
                ),
                SizedBox(width: 10),
                Text(
                  option['label'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff343A40),
                    fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}



