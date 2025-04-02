import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String subTitle;
  final Color subTitlecolor;
  final String title;
  final Color titleColor;
  final Color background;

  const BalanceCard({
    required this.title,
    required this.subTitle,
    required this.subTitlecolor,
    required this.titleColor,
    required this.background,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card Saldo Atual Total
      margin: EdgeInsets.all(8),
      elevation: 4,
      color: background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: subTitlecolor),
            ),
          ],
        ),
      ),
    );
  }
}
