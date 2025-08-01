import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/pages/expenses/expense_controller.dart';
import 'package:app_money_flow/src/widgets/modals/AccountModal/account_modal.dart';
import 'package:app_money_flow/src/widgets/modals/TransactionModal/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:app_money_flow/src/pages/home/home.dart';
import 'package:app_money_flow/src/pages/expenses/expenses_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isExpanded = false;
  bool showReceitaCard = false;

  final ExpensesController expensesController = GetIt.I<ExpensesController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> handleOpenTransactionModal(
      {required TransactionType typeModal}) async {
    setState(() {
      isExpanded = false;
    });

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => TransactionModal(type: typeModal),
    );

    if (result != false) {
      // aceita true ou null
      await expensesController.loadTransactions();
      await expensesController.loadTransactionByCategory();
    }
  }

  Future<void> handleOpenAccountModal() async {
    setState(() {
      isExpanded = false;
    });

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const AccountModal(),
    );
    if (result != false) {
      // aceita true ou null
      await expensesController.loadTransactions();
      await expensesController.loadTransactionByCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: expensesController,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned.fill(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Home(),
                  ExpensesPage(),
                ],
              ),
            ),
            if (!showReceitaCard)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isExpanded) _buildActionButtons(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
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
      ),
    );
  }

  Widget _buildActionButtons() {
    final List<Map<String, dynamic>> options = [
      {
        'label': 'Nova Receita',
        'color': const Color(0xFFEBFBEE),
        'icon': 'assets/icons/income_icon.svg',
        'onTap': () =>
            handleOpenTransactionModal(typeModal: TransactionType.income),
      },
      {
        'label': 'Nova Despesa',
        'color': const Color(0xFFFFF5F5),
        'icon': 'assets/icons/expense_icon.svg',
        'onTap': () =>
            handleOpenTransactionModal(typeModal: TransactionType.expense),
      },
      {
        'label': 'Nova Conta Bancária',
        'color': const Color(0xFFEDF2FF),
        'icon': 'assets/icons/bank_icon.svg',
        'onTap': handleOpenAccountModal,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                alignment: Alignment.centerLeft,
              ),
              onPressed: option['onTap'],
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
      ),
    );
  }
}
