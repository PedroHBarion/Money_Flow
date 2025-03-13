import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateUserProfile extends StatelessWidget {
  const CreateUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: PreferredSize(
    preferredSize: const Size.fromHeight(80), // Define a altura da AppBar
    child: AppBar(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      elevation: 4,
      shadowColor: Colors.black12,
      centerTitle: true,
      title: Column(
        children: [
          const SizedBox(height: 30), // Adiciona espaçamento no topo
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/Carteira.svg',
                height: 30,
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              const Text(
                'MoneyFlow',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),),),

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
            const Text(
              'Ao continuar, estou de acordo com os Termos de Uso e com o Aviso de Privacidade do MoneyFlow.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navegação para próxima tela
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
