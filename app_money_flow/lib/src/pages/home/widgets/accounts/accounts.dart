import 'package:app_money_flow/src/pages/home/widgets/accounts/accounts_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/account_card.dart';

class AccountBalanceCard extends StatefulWidget {
  const AccountBalanceCard({super.key});

  @override
  State<AccountBalanceCard> createState() => _AccountBalanceCardState();
}

class _AccountBalanceCardState extends State<AccountBalanceCard> {
  @override
  void initState() {
    super.initState();

    // Carrega as contas ao iniciar
    Future.microtask(() {
      final controller = context.read<AccountsController>();
      controller.loadAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AccountsController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF087F5B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saldo total',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              controller.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'R\$ ${controller.totalBalance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: controller.isHidden ? Colors.transparent : Colors.white,
                        shadows: controller.isHidden
                            ? [
                                const Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 50,
                                  color: Colors.white,
                                )
                              ]
                            : [],
                      ),
                    ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  controller.isHidden ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: controller.toggleHidden,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Minhas Contas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFFFFF),
            ),
          ),
          const SizedBox(height: 16),
          controller.isLoading
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : controller.accounts.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8,
                        children: [
                          ...controller.accounts.map((acc) => AccountCard(
                                type: acc.type,
                                accountName: acc.name,
                                balance: 'R\$ ${acc.currentBalance.toStringAsFixed(2)}',
                                color: acc.color,
                                isHidden: controller.isHidden
                              )),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        print("Cadastrar nova conta!");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF087F5B),
                        foregroundColor: const Color(0xFFFFFFFF),
                        fixedSize: const Size(265, 200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Color(0xffffffff)),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(Icons.add, size: 24, color: Color(0xffffffff)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Cadastre uma\nnova conta",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}
