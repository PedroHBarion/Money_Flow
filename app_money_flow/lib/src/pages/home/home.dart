import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts.dart';
import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions_controller.dart';
import 'package:app_money_flow/src/widgets/app_bar.dart';
import 'package:app_money_flow/src/pages/home/widgets/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _refreshData() async {
    await GetIt.I<TransactionsController>().fetchTransactions();
    await GetIt.I<AccountsController>().loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80), child: CustomAppBar()),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: const Color(0xFF087F5B),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AccountBalanceCard(),
              SizedBox(height: 16),
              Transactions(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
