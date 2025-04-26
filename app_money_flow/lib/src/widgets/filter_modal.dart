import 'package:app_money_flow/src/core/config/locator.dart';
import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  final Function(String?) onTempAccountChanged;
  final Function(int?) onTempYearChanged;
  final VoidCallback onApplyFilters;
  final VoidCallback onClearFilters;

  const FilterModal({
    super.key,
    required this.onTempAccountChanged,
    required this.onTempYearChanged,
    required this.onApplyFilters,
    required this.onClearFilters,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final accountsController = getIt<AccountsController>();

  late List<BankAccountModel> accounts;
  String? selectedAccountId;
  int? selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
    accounts = accountsController.accounts;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filtros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Dropdown de contas
            DropdownButtonFormField<String>(
              value: selectedAccountId,
              decoration: InputDecoration(labelText: 'Conta'),
              items: accounts
                  .map((account) => DropdownMenuItem(
                        value: account.id,
                        child: Text(account.name),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedAccountId = value);
                widget.onTempAccountChanged(value);
              },
            ),

            const SizedBox(height: 16),

            // Dropdown de ano
            DropdownButtonFormField<int>(
              value: selectedYear,
              decoration: InputDecoration(labelText: 'Ano'),
              items: [2022, 2023, 2024, 2025]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedYear = value);
                widget.onTempYearChanged(value);
              },
            ),

            const SizedBox(height: 24),

            // Botão aplicar filtros
            ElevatedButton(
              onPressed: () {
                widget.onApplyFilters();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF087F5B),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('Aplicar Filtros', style: TextStyle(fontWeight: FontWeight.w700)),
            ),

            const SizedBox(height: 12),

            // Botão limpar filtros
            TextButton(
              onPressed: () {
                setState(() {
                  selectedAccountId = null;
                  selectedYear = DateTime.now().year;
                });
                widget.onClearFilters();
                Navigator.pop(context);
              },
              child: Text('Limpar Filtros', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
