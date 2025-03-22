import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionDTO {
  final String question;
  final List<String> options;

  QuestionDTO({required this.question, required this.options});

  factory QuestionDTO.fromMap(Map<String, dynamic> map) {
    return QuestionDTO(
      question: map['question'] as String,
      options: List<String>.from(map['options']),
    );
  }
}

class CreateUserProfile1 extends StatefulWidget {
  const CreateUserProfile1({super.key});

  @override
  State<CreateUserProfile1> createState() => _CreateUserProfile1State();
}

class _CreateUserProfile1State extends State<CreateUserProfile1> {
  int _currentStep = 0;
  String? _selectedOption;

  final List<QuestionDTO> _questions = [
    {
      'question': 'Qual sua principal\nfonte de renda?',
      'options': [
        'Bolsa/Estágio',
        'Trabalho CLT',
        'Autônomo/Freelancer',
        'Ajuda de Familiares',
        'Outro(s)',
      ],
    },
    {
      'question': 'Você já teve dificuldades para fechar o mês financeiramente?',
      'options': [
        'Sim, frequentemente',
        'Às vezes, depende dos gastos',
        'Não, costumo me planejar bem',
      ],
    },
    {
      'question': 'Qual seu maior desafio financeiro?',
      'options': [
        'Gastar menos com lazer/compras impulsivas',
        'Economizar dinheiro para investimentos',
        'Organizar melhor as contas fixas',
        'Aprender mais sobre finanças',
      ],
    },
    {
      'question': 'O que você mais quer melhorar nas suas finanças?',
      'options': [
        'Aprender a economizar mais',
        'Criar um orçamento mensal',
        'Controlar melhor meus gastos diários',
        'Descobrir formas sustentáveis de consumir',
      ],
    },
  ].map((q) => QuestionDTO.fromMap(q)).toList();

  void _nextQuestion() {
    if (_selectedOption != null) {
      if (_currentStep < _questions.length - 1) {
        setState(() {
          _currentStep++;
          _selectedOption = null;
        });
      } else {
        print("Finalizado: $_selectedOption");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/Carteira.svg',
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'MoneyFlow',
                    style: TextStyle(
                      fontSize: 16,
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
            Text(
              _questions[_currentStep].question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ..._questions[_currentStep].options.map<Widget>(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: _selectedOption == option
                              ? Colors.green
                              : Colors.black12,
                        ),
                      ),
                      backgroundColor:
                          _selectedOption == option ? Colors.green[100] : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedOption = option;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedOption == option ? Colors.green : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087F5B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Continuar',
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