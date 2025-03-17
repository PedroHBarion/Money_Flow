import 'package:flutter/gestures.dart'; // Adicione esta linha
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateUserProfile extends StatelessWidget {
  const CreateUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/Carteira.svg',
                    height: 25,
                    colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'MoneyFlow',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
            SvgPicture.asset('assets/images/Questions.svg', height: 150),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navegação para a segunda tela (CreateUserProfile)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateUserProfile()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087F5B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Concordar e Continuar',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
