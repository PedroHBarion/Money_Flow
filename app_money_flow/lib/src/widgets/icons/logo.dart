import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double iconSize;
  final double fontSize;

  const Logo({
    super.key,
    this.color = const Color(0xFF087F5B),
    this.iconSize = 24,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/logo.svg',
          width: iconSize,
          height: iconSize,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        const SizedBox(width: 8),
        Text(
          'MoneyFlow',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
