import 'package:app_money_flow/src/widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeQuestionsStep extends StatelessWidget {
  final VoidCallback onContinue;

  const WelcomeQuestionsStep({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Olá!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Vamos entender melhor seu perfil financeiro para oferecer recomendações personalizadas.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            const Text(
              'Responda algumas rápidas perguntas!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF087F5B),
              ),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset('assets/images/questions_image.svg', height: 150),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                children: [
                  const TextSpan(text: 'Ao continuar, estou de acordo com os '),
                  TextSpan(
                    text: 'Termos de Uso',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF087F5B),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Clicou nos Termos de Uso");
                      },
                  ),
                  const TextSpan(text: ' e com o '),
                  TextSpan(
                    text: 'Aviso de Privacidade',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF087F5B),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Clicou no Aviso de Privacidade");
                      },
                  ),
                  const TextSpan(text: ' do MoneyFlow.'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Button(
              text: 'Concordar e Continuar',
              onPressed: () => onContinue(),
              variant: ButtonVariant.normal,
            ),
          ],
        ),
      ),
    );
  }
}
