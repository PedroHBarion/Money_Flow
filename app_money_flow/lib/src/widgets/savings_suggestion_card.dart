import 'package:app_money_flow/src/core/routes/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_money_flow/src/core/controller/expense_controller.dart';

class SavingsSuggestionCard extends StatelessWidget {
  const SavingsSuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final expensesController = Provider.of<ExpensesController>(context);

    return Card(
      color: Color(0xFFFFFFFF),
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.green),
                SizedBox(width: 8),
                const Text(
                  'Sugestão de economia:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expensesController.highestCategoryMessage,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF868E96),
                      fontFamily: "DM Sans",
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainNavigation(),
                          ),
                        );
                      },
                      child: const Text(
                        "Mais sugestões com a IA",
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF087F5B),
                          height: 1.5,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
