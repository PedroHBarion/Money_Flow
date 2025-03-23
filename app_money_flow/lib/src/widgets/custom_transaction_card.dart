import 'package:flutter/material.dart';

class CustomTransactionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String extraText;

  const CustomTransactionCard({super.key, 
    required this.icon,
    required this.title,
    required this.value,
    required this.extraText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
      margin: EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Ícone
            Icon(
              icon,
              color: Colors.green,
            ),
            SizedBox(width: 10), // Espaçamento entre o ícone e o título
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Valor ("Roupas") com a cor #868E96
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF868E96), // Cor #868E96
                  ),
                ),
              ],
            ),
            Spacer(),
            // Texto adicional "-R$ 693,00" com a cor rgba(224, 49, 49, 1)
            Text(
              extraText,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(224, 49, 49, 1), // Cor rgba(224, 49, 49, 1)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
