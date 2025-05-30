import 'package:app_money_flow/src/core/models/questions_model.dart';
import 'package:app_money_flow/src/core/models/user_answers_model.dart';
import 'package:app_money_flow/src/core/services/questions_service.dart';
import 'package:app_money_flow/src/core/services/user_answers_service.dart';
import 'package:app_money_flow/src/core/utils/show_toast.dart';
import 'package:flutter/material.dart';

class ProfileFlowController extends ChangeNotifier {
  final QuestionsService _questionsService;
  final UserAnswersService _userAnswersService;

  ProfileFlowController(this._questionsService, this._userAnswersService);

  final PageController pageController = PageController();

  List<QuestionModel> questions = [];
  Map<String, String> selectedAnswers = {}; // questionId -> answerId

  bool isLoading = false;
  String? errorMessage;
  int currentPageIndex = 0;

  /// Carrega perguntas da API
  Future<void> loadQuestions() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      questions = await _questionsService.getAll();
    } catch (e) {
      errorMessage = 'Erro ao carregar perguntas. Tente novamente.';
    }

    isLoading = false;
    notifyListeners();
  }

  /// Salva a resposta selecionada (agora em um único lugar)
  void selectAnswer(String questionId, String answerId) {
    selectedAnswers[questionId] = answerId;

    notifyListeners();
  }

  /// Recupera resposta selecionada (texto ou id)
  String? selectedOptionFor(String questionId) {
    return selectedAnswers[questionId];
  }

  /// Verifica se pode continuar (para perguntas)
  bool canContinue() {
    if (currentPageIndex == 0 || currentPageIndex == totalSteps - 1) {
      return true;
    }

    final questionIndex = currentPageIndex - 1;
    if (questionIndex >= 0 && questionIndex < questions.length) {
      final questionId = questions[questionIndex].id;
      return selectedAnswers.containsKey(questionId);
    }
    return false;
  }

  //Verifica se todas as perguntas foram respondidas
  bool allQuestionsAnswered() {
    return selectedAnswers.length == questions.length;
  }

  /// Avança para próxima página se permitido
  void nextPage(BuildContext context) {
    if (!canContinue()) return;

    // Estamos na última pergunta?
    final isLastQuestion = currentPageIndex == totalSteps - 2;

    if (isLastQuestion) {
      // Se todas as perguntas foram respondidas, envia os dados
      if (allQuestionsAnswered()) {
        submitAnswers(context); // Avança para AcceptTerms dentro do método
      } else {
        Toast.error('Responda todas as perguntas antes de continuar.');
      }
    } else {
      currentPageIndex++;
      pageController.animateToPage(
        currentPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  /// Volta para a página anterior
  void previousPage() {
    if (currentPageIndex == 0) return;

    currentPageIndex--;
    pageController.animateToPage(
      currentPageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  /// Quantidade total de páginas (welcome + perguntas + terms)
  int get totalSteps => 2 + questions.length;

  // Envia os dados para a API
  Future<void> submitAnswers(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final answers = selectedAnswers.entries.map((entry) {
        return UserAnswerModel(
          questionId: entry.key,
          answerId: entry.value,
        );
      }).toList();

      await _userAnswersService.submitAnswers(answers);

      // Avança para AcceptTermsStep (última página)
      currentPageIndex++;
      pageController.animateToPage(
        currentPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      debugPrint("Erro ao enviar as respostas $e");
      Toast.error('Erro ao enviar respostas. Tente novamente.');
    }

    isLoading = false;
    notifyListeners();
  }
}
