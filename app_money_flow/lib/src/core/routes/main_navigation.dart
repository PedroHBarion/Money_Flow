import 'package:flutter/material.dart';
import 'package:app_money_flow/src/pages/home/home.dart';
import 'package:app_money_flow/src/pages/expenses/expenses_page.dart';

/// Classe responsável por gerenciar a navegação principal do aplicativo.
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    /// Inicializa o controlador de abas com duas opções.
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
        children: [
          /// Exibe o conteúdo da aba correspondente.
          Positioned.fill(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [Home(), ExpensesPage()],
            ),
          ),
          /// Barra de navegação flutuante centralizada na parte inferior.
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}