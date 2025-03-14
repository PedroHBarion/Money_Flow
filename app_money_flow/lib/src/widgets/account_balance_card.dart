import 'package:flutter/material.dart';

class AccountBalanceCard extends StatelessWidget {
  const AccountBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: Color(0xFF087F5B),
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
              fontWeight: FontWeight.w400
            ),
          ),
          Row(
           children: [
            const Text(
            'R\$ 100,00',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF)),
            ),
             IconButton(
                icon: const Icon(
                  Icons.visibility_off ,
                  color: Color(0xFFFFFFFF)
                ),
                onPressed: () {},
              ),
           ],
          ),
          SizedBox(height: 40),
          const Text(
            'Minhas Contas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFFFFF)),
            ),
           SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomAccountCard(
                    icon: Icons.account_balance_wallet,
                    accountName: 'Nubank',
                    balance: 'R\$ 123,00',
                  ),
                  SizedBox(width: 8),
                  CustomAccountCard(
                    icon: Icons.account_balance_wallet,
                    accountName: 'Nubank',
                    balance: 'R\$ 123,00',
                  ),
                ],
              ),
            )
        ]
      ),
    );   
  }
}


class CustomAccountCard extends StatelessWidget {
  final IconData icon;
  final String accountName;
  final String balance;

  const CustomAccountCard(
    {super.key, 
    required this.icon,
    required this.accountName,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 260,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFE9ECEF),
            radius: 21,
            child: Icon(icon, size: 24, color: Color(0xFF343A40)),
          ),
          SizedBox(height: 16),
          Text(
            accountName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF343A40),
            ),
          ),
           SizedBox(height: 42),
           Text(
            balance,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF343A40),
            ),
          ),
          Text(
            'Saldo Atual',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF868E96),
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}
