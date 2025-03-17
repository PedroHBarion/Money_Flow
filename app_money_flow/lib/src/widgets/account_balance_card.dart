import 'package:flutter/material.dart';

class AccountBalanceCard extends StatefulWidget {
  const AccountBalanceCard({super.key});

  @override
  State<AccountBalanceCard> createState() => _AccountBalanceCardState();
}

class _AccountBalanceCardState extends State<AccountBalanceCard> {
   bool isHidden = false;

  var onPressed = () {
    print("Botão pressionado!");
  };
 
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
            Text(
            'R\$ 100,00',
           style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isHidden ? Colors.transparent : Colors.white, // Oculta o texto
                shadows: isHidden
                    ? [Shadow(offset: Offset(0, 0), blurRadius: 50, color: Colors.white)]
                    : [], // Aplica um "borrado" fake
              ),),
              SizedBox(width: 8),
             IconButton(
                icon: Icon(
                  isHidden ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
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
                spacing: 8,
                children: [
                  CustomAccountCard(
                    icon: Icons.account_balance_wallet,
                    accountName: 'Nubank',
                    balance: 'R\$ 123,00',
                  ),
                  
                  CustomAccountCard(
                    icon: Icons.account_balance_wallet,
                    accountName: 'Nubank',
                    balance: 'R\$ 123,00',
                  ),
                  ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF087F5B), 
                        foregroundColor: Color(0xFFFFFFFF),
                        fixedSize: Size(265, 200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Color(0xffffffff),)
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
                            child: const Icon(Icons.add, size: 24, color: Color(0xffffffff),),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Cadastre uma\nnova conta",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),),
                  
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
