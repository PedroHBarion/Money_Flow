import 'package:app_money_flow/src/core/utils/hex_to_color.dart';
import 'package:app_money_flow/src/widgets/icons/bank_account_type_icon.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String type;
  final String accountName;
  final String balance;
  final String color;
  final bool isHidden;

  const AccountCard(
    {super.key, 
    required this.type,
    required this.accountName,
    required this.balance,
    required this.color,
    required this.isHidden,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 260,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
        bottom: BorderSide(
          color: hexToColor(color), // verde visível
          width: 3,
          style: BorderStyle.solid,
        ),
      ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFE9ECEF),
            radius: 21,
            child: BankAccountTypeIcon(type: type,),
          ),
          SizedBox(height: 16),
          Text(
            accountName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF343A40),
            ),
          ),
           SizedBox(height: 32),
          Text(
            balance,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isHidden ? Colors.transparent : const Color(0xFF343A40),
              shadows: isHidden
                  ? [
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 20,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ]
                  : [],
            ),
          ),
          Text(
            'Saldo Atual',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF868E96),
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}



