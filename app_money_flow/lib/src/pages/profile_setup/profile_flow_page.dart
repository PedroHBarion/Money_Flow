import 'package:app_money_flow/src/core/models/questions_model.dart';
import 'package:app_money_flow/src/core/routes/app_routes.dart';
import 'package:app_money_flow/src/pages/profile_setup/profile_flow_controller.dart';
import 'package:app_money_flow/src/pages/profile_setup/widgets/accept_terms_step.dart';
import 'package:app_money_flow/src/pages/profile_setup/widgets/question_step.dart';
import 'package:app_money_flow/src/pages/profile_setup/widgets/welcome_questions_step.dart';
import 'package:app_money_flow/src/widgets/icons/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFlowPage extends StatefulWidget {
  const ProfileFlowPage({super.key});

  @override
  State<ProfileFlowPage> createState() => _ProfileFlowPageState();
}

class _ProfileFlowPageState extends State<ProfileFlowPage> {
  late final ProfileFlowController controller;

  @override
  void initState() {
    super.initState();
    controller = ProfileFlowController();
    controller.loadQuestions();
  }

  @override
  void dispose() {
    controller.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<ProfileFlowController>(
        builder: (context, controller, _) {
          if (controller.errorMessage != null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.errorMessage!),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.loadQuestions,
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final pages = [
            WelcomeQuestionsStep(
              onContinue: () => controller.nextPage(context),
            ),
            ...controller.questions.map(
              (question) {
                final selectedAnswerId =
                    controller.selectedOptionFor(question.id);
                final selectedAnswerText = question.answers
                    .firstWhere((a) => a.id == selectedAnswerId,
                        orElse: () => AnswerModel(id: '', text: ''))
                    .text;

                return QuestionStep(
                  questionId: question.id,
                  question: question.text,
                  options: question.answers.map((a) => a.text).toList(),
                  selectedOption:
                      selectedAnswerText, // agora o componente compara texto com texto
                  onSelect: (selectedText) {
                    final answer = question.answers.firstWhere(
                      (a) => a.text == selectedText,
                      orElse: () => question.answers.first,
                    );

                    controller.selectAnswer(question.id, answer.id);
                  },
                  onContinue: () => controller.nextPage(context),
                );
              },
            ),
            AcceptTermsStep(
              onAccept: () {
                // Aqui você redireciona, salva no backend, etc.
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.splash,
                  (route) => false,
                );
              },
            ),
          ];

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Logo(
                      color: Colors.grey,
                      fontSize: 20,
                      iconSize: 25,
                    )),
              ),
              body: Stack(
                children: [
                  PageView(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: pages,
                  ),
                  if (controller.isLoading)
                    const Positioned.fill(
                      child: ColoredBox(
                        color: Colors.white54,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ));
        },
      ),
    );
  }
}
