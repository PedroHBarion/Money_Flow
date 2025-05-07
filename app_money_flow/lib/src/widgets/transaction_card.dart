import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/utils/format_currency.dart';
import 'package:app_money_flow/src/widgets/icons/category_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransactionCard extends StatelessWidget {
  final String? icon;
  final TransactionType type;
  final String title;
  final String date;
  final double amount;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.type,
    required this.title,
    required this.date,
    required this.amount,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Ícone com fundo circular
              SvgPicture.asset(
                getCategoryIconPath(type: type.value, subcategory: icon),
                width: 44,
                height: 44,
              ),

              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff343A40),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff868E96),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                (type.value == 'INCOME' ? '+R\$' : '-R\$') +
                    formatCurrency(amount),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: type.value == 'INCOME'
                      ? Color(0xFF2F9E44)
                      : Color(0xFFE03131),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
