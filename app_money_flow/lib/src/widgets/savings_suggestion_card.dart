import 'package:flutter/material.dart';

class SavingsSuggestionCard extends StatelessWidget {
  const SavingsSuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text(
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
              padding: const EdgeInsets.only(
                left: 32.0,
              ), // Adicionando o espaçamento para alinhar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seus gastos com roupas foram maiores este mês! Que tal explorar brechós? '
                    'Você reduz seu gasto e ajuda o meio ambiente. 🌱👕',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF868E96), // Cor #868E96
                      fontFamily: "DM Sans",
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mais sugestões com a IA',
                    style: TextStyle(
                      fontFamily: 'DM Sans', // Font family
                      fontSize: 16, // Font size
                      fontStyle: FontStyle.normal, // Font style
                      fontWeight: FontWeight.w400, // Font weight
                      color: Color(0xFF087F5B), // Color (#087F5B)
                      height: 1.5, // Line height (150% of font size = 21px)
                      decoration:
                          TextDecoration.underline, // Underline decoration
                      decorationStyle:
                          TextDecorationStyle.solid, // Solid underline
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
