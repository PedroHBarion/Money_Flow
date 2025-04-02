import 'package:flutter/material.dart';

class CustomMonthNavigation extends StatelessWidget {
  final int currentMonthIndex;
  final Function(int) onMonthChanged; // Função de callback para notificar o pai

  const CustomMonthNavigation({super.key, 
    required this.currentMonthIndex,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Lista de meses diretamente no widget
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    // Meses para exibir: anterior, atual, próximo
    List<String> displayedMonths = [
      months[(currentMonthIndex - 1 + 12) % 12], // Mês anterior
      months[currentMonthIndex], // Mês atual
      months[(currentMonthIndex + 1) % 12], // Mês seguinte
    ];

    return SizedBox(
      width: 311, // Largura definida conforme seu CSS
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment
                .center, // Equivalente ao align-items: center no CSS
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed:
                () => onMonthChanged(
                  (currentMonthIndex - 1 + 12) % 12,
                ), // Mês anterior
          ),
          SizedBox(width: 16), // Espaço entre os ícones e os meses

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Mês anterior (clicável)
                GestureDetector(
                  onTap:
                      () => onMonthChanged((currentMonthIndex - 1 + 12) % 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      displayedMonths[0],
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF495057),
                        letterSpacing: -0.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                // Mês atual (com a bola branca)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40, // Ajustado para ficar mais encaixado
                        height: 40, // Ajustado para ficar mais encaixado
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 236, 236, 236),
                        ),
                        margin: const EdgeInsets.only(bottom: 8.0),
                      ),
                      Text(
                        displayedMonths[1],
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF343A40),
                          letterSpacing: -0.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                // Mês seguinte (clicável)
                GestureDetector(
                  onTap: () => onMonthChanged((currentMonthIndex + 1) % 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      displayedMonths[2],
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF495057),
                        letterSpacing: -0.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 16), // Espaço entre os meses e o ícone de navegação
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () => onMonthChanged((currentMonthIndex + 1) % 12),
          ),
        ],
      ),
    );
  }
}
