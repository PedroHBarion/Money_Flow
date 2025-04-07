import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


String getBankAccountIconPath(String type) {
  switch (type) {
    case 'CHECKING':
      return 'assets/icons/bankAccounts/checking.svg';
    case 'INVESTMENT':
      return 'assets/icons/bankAccounts/investment.svg';
    case 'CASH':
      return 'assets/icons/bankAccounts/cash.svg';
    default:
      return 'assets/icons/bankAccounts/checking.svg'; 
  }
}



class BankAccountTypeIcon extends StatelessWidget {
  final String type;
  final double size;

  const BankAccountTypeIcon({
    required this.type,
    this.size = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      getBankAccountIconPath(type),
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
