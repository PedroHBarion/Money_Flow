import 'package:flutter/material.dart';
import 'package:app_money_flow/src/pages/home/home.dart';
import 'package:app_money_flow/src/pages/expenses/expenses_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Classe responsável por gerenciar a navegação principal do aplicativo.
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    /// Inicializa o controlador de abas com duas opções: Home e Expenses.
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    /// Libera os recursos do controlador de abas ao fechar a tela.
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          /// Exibe o conteúdo da aba correspondente à seleção do usuário.
          Positioned.fill(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [Home(), ExpensesPage()],
            ),
          ),

          /// Barra de navegação flutuante na parte inferior.
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Exibe os botões de ação quando expandido, **acima** do botão verde
                  if (isExpanded) _buildActionButtons(),

                  /// Container agrupando o botão e a barra de navegação
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        /// Barra de navegação inferior
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.green,
                              labelColor: Colors.green,
                              unselectedLabelColor: Colors.black54,
                              indicatorWeight: 3,
                              tabs: const [
                                Tab(icon: Icon(Icons.home, size: 28)),
                                Tab(icon: Icon(Icons.pie_chart, size: 28)),
                              ],
                            ),
                          ),
                        ),

                        /// Botão flutuante sobreposto à barra
                        Positioned(
                          child: FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            backgroundColor: Colors.green,
                            elevation: 8,
                            shape: const CircleBorder(),
                            child: Icon(
                              isExpanded ? Icons.close : Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói os botões de ação exibidos ao expandir o menu.
  Widget _buildActionButtons() {
    final List<Map<String, dynamic>> options = [
      {
        'label': 'Receitas',
        'color': Color(0xFFEBFBEE),
        'icon': 'assets/icons/income_icon.svg',
      },
      {
        'label': 'Despesas',
        'color': Color(0xFFFFF5F5),
        'icon': 'assets/icons/expense_icon.svg',
      },
      {
        'label': 'Transações',
        'color': Color(0xFFEDF2FF),
        'icon': 'assets/icons/bank_icon.svg',
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
            onPressed: () {
              print("${option['label']} clicado!");
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: option['color'],
                  radius: 16,
                  child: SvgPicture.asset(
                    option['icon'],
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  option['label'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff343A40),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
