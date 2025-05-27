import 'package:app_money_flow/src/widgets/button.dart';
import 'package:flutter/material.dart';

class QuestionStep extends StatelessWidget {
  final String questionId;
  final String question;
  final List<String> options;
  final String? selectedOption;
  final void Function(String) onSelect;
  final VoidCallback onContinue;

  const QuestionStep({
    super.key,
    required this.questionId,
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...options.map((option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: GestureDetector(
                  onTap: () {
                    onSelect(option);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: selectedOption == option
                          ? Colors.green[100]
                          : Colors.white,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedOption == option
                            ? Colors.green[900]
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 20),
          Button(
            text: 'Continuar',
            onPressed: selectedOption != null ? onContinue : null,
            variant: selectedOption == null
                ? ButtonVariant.ghost
                : ButtonVariant.normal,
            disabled: selectedOption == null ? true : false,
          ),
        ],
      ),
    );
  }
}
