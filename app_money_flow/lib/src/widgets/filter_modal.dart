import 'package:flutter/material.dart';

class FilterModal extends StatelessWidget {
  final Function(String?) onAccountSelected;
  final Function(int?) onYearSelected;

  const FilterModal({super.key, required this.onAccountSelected, required this.onYearSelected});

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
              spacing: 40,
              children: [
                Text(
                  'Filtros',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                
                DropdownButtonFormField<String>(
                  dropdownColor: Color(0xffFFFFFF),
                  decoration: InputDecoration(labelText: 'Conta'),
                  items: ['XP Investimentos', 'Nubank', 'Carteira']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: onAccountSelected,
                ),
               
                DropdownButtonFormField<int>(
                  dropdownColor: Color(0xffFFFFFF),
                  decoration: InputDecoration(labelText: 'Ano'),
                  items: [2022, 2023, 2024, 2025]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
                      .toList(),
                  onChanged: onYearSelected,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color(0xFF087F5B),
                    foregroundColor: Color(0xffFFFFFF),
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Aplicar Filtros',
                  style: TextStyle(
                    fontWeight: FontWeight.w700
                  ),),
                ),
              ],
            ),
          ),
    );
  }
}
