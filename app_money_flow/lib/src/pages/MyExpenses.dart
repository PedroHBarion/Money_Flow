import 'package:flutter/material.dart';

// Função principal que inicia o app
void main() {
  runApp(MyApp());
}

// Criação de um widget Stateless (que não muda o estado)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyFlow', // Título do app
      home: MonthNavigatorPage(), // A página inicial do app
    );
  }
}

// StatefulWidget para a página de navegação entre meses
// Stateful porque o mês atual muda ao navegar
class MonthNavigatorPage extends StatefulWidget {
  @override
  _MonthNavigatorPageState createState() => _MonthNavigatorPageState();
}

// Estado da página que gerencia a lógica de navegação
class _MonthNavigatorPageState extends State<MonthNavigatorPage> {
  // Lista de meses, uma boa prática aqui seria usar a internacionalização (i18n) para traduzir os meses automaticamente.
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  // Variável que controla o índice do mês atual
  int currentMonthIndex = 4; // Inicializando para "Mai" (índice 4, que representa Maio)

  // Função que retrocede o mês ao clicar no botão de voltar
  void _prevMonth() {
    setState(() {
      if (currentMonthIndex > 0) {
        currentMonthIndex--; // Decrementa o índice, indo para o mês anterior
      }
    });
  }

  // Função que avança o mês ao clicar no botão de avançar
  void _nextMonth() {
    setState(() {
      if (currentMonthIndex < months.length - 1) {
        currentMonthIndex++; // Incrementa o índice, indo para o mês seguinte
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MoneyFlow'), // Título da barra superior
        centerTitle: true, // Centraliza o título no AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Ícone de notificação à direita
            onPressed: () {
              // Aqui você pode adicionar uma função que será acionada quando o ícone for pressionado
            },
          ),
        ],
      ),
      // Corpo principal da tela
      body: Column(
        children: [
          // Navegação entre os meses usando ícones de seta
          Padding(
            padding: const EdgeInsets.all(16.0), // Define o espaçamento em volta da linha
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribui os botões de forma igual
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back), // Ícone de seta para voltar
                  onPressed: _prevMonth, // Chama a função para voltar um mês
                ),
                Text(
                  months[currentMonthIndex], // Exibe o mês atual com base no índice
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo do texto
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward), // Ícone de seta para avançar
                  onPressed: _nextMonth, // Chama a função para avançar um mês
                ),
              ],
            ),
          ),
          // Espaço reservado para os cartões de "Saldo Atual Total" e "Gastos Previstos"
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribui os cartões igualmente no espaço disponível
              children: [
                _buildCard('Saldo Atual Total', 'R\$ 59,45', Colors.green), // Chama a função para criar um cartão
                _buildCard('Gastos Previstos', 'R\$ 2936,00', Colors.red), // Outro cartão com valores de gastos previstos
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Função que constrói um cartão customizado para exibir o saldo ou gastos
  Widget _buildCard(String title, String amount, Color color) {
    return Container(
      padding: EdgeInsets.all(16), // Define espaçamento interno do container
      decoration: BoxDecoration(
        color: Colors.white, // Cor de fundo branco
        borderRadius: BorderRadius.circular(8), // Bordas arredondadas
        border: Border.all(color: color, width: 2), // Borda colorida
      ),
      width: 150, // Largura fixa
      height: 100, // Altura fixa
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo dentro do cartão
        children: [
          Text(
            title, // Título do cartão (ex: "Saldo Atual Total")
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Estilo do texto
            textAlign: TextAlign.center, // Centraliza o texto
          ),
          SizedBox(height: 8), // Espaçamento vertical entre o título e o valor
          Text(
            amount, // Valor do cartão (ex: "R\$ 59,45")
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color), // Estilo do texto com a cor definida
            textAlign: TextAlign.center, // Centraliza o valor
          ),
        ],
      ),
    );
  }
}
