import 'package:app_money_flow/src/widgets/account_balance_card.dart';
import 'package:app_money_flow/src/widgets/custom_app_bar.dart';
import 'package:app_money_flow/src/widgets/navigation_bar.dart';
import 'package:app_money_flow/src/widgets/transactions_container.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    int selectedIndex = 0;

  void onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80), child: CustomAppBar()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AccountBalanceCard(),
                SizedBox(height: 16),
                TransactionsContainer(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(
            currentIndex: selectedIndex,
            onItemSelected: onItemSelected,
      ),
      );
  }
}
