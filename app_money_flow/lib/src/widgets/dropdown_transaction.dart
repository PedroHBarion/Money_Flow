import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DropdownTransaction extends StatefulWidget {
  const DropdownTransaction({super.key});

  @override
  _DropdownTransactionState createState() => _DropdownTransactionState();
}

class _DropdownTransactionState extends State<DropdownTransaction> {
  String selectedValue = 'Transações';


  final List<Map<String, dynamic>> options = [
    {'label': 'Receitas', 'color': Color(0xFFEBFBEE), 'icon': 'assets/icons/income_icon.svg'},
    {'label': 'Despesas', 'color': Color(0xFFFFF5F5), 'icon': 'assets/icons/expense_icon.svg'},
    {'label': 'Transações', 'color': Color(0xFFEDF2FF), 'icon': 'assets/icons/bank_icon.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(16),
        value: selectedValue,
        style: TextStyle(color: Colors.black, fontSize: 16),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedValue = newValue;
            });
          }
        },
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



