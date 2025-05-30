import 'package:app_money_flow/src/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AcceptTermsStep extends StatelessWidget {
  final VoidCallback onAccept;

  const AcceptTermsStep({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Muito bem!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Respostas enviadas com sucesso!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            const Text(
              'Vamos juntos fazer essas metas se concretizarem!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF087F5B),
              ),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/images/phone.svg',
              height: 150,
            ),
            const SizedBox(height: 20),
             Button(
                text: 'Ir para a Tela Inicial',
                onPressed: onAccept,
                variant: ButtonVariant.normal,
              ),
          ],
        ),
      );
  }
}
