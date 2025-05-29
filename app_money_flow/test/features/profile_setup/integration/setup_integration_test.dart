import 'package:app_money_flow/src/pages/profile_setup/profile_flow_page.dart';
import 'package:app_money_flow/src/core/models/questions_model.dart';
import 'package:app_money_flow/src/core/services/questions_service.dart';
import 'package:app_money_flow/src/core/services/user_answers_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import '../mock/setup.mocks.dart';

void main() {
  late MockQuestionsService mockQuestionsService;
  late MockUserAnswersService mockUserAnswersService;

  setUp(() {
    mockQuestionsService = MockQuestionsService();
    mockUserAnswersService = MockUserAnswersService();

    GetIt.I.reset();
    GetIt.I.registerSingleton<QuestionsService>(mockQuestionsService);
    GetIt.I.registerSingleton<UserAnswersService>(mockUserAnswersService);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Permite navegação até última etapa (Aceitação de termos)',
      (WidgetTester tester) async {
    final mockQuestions = [
      QuestionModel(
        id: 'q1',
        text: 'Qual seu objetivo financeiro?',
        answers: [
          AnswerModel(id: 'a1', text: 'Economizar'),
          AnswerModel(id: 'a2', text: 'Investir'),
        ],
      ),
      QuestionModel(
        id: 'q2',
        text: 'Meta financeira?',
        answers: [
          AnswerModel(id: 'a1', text: 'Poupar'),
          AnswerModel(id: 'a2', text: 'Investir'),
        ],
      ),
    ];

    when(mockQuestionsService.getAll()).thenAnswer((_) async => mockQuestions);
    when(mockUserAnswersService.submitAnswers(any)).thenAnswer((_) async {});

    await tester.pumpWidget(
      const MaterialApp(home: ProfileFlowPage()),
    );

    await tester.pumpAndSettle();

    // Etapa de boas-vindas
    await tester.tap(find.text('Concordar e Continuar'));
    await tester.pumpAndSettle();

    // Primeira pergunta
    await tester.tap(find.text('Economizar'));
    await tester.pump();
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    // Segunda pergunta
    await tester.tap(find.text('Poupar'));
    await tester.pump();
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    // Verifica se chegou na etapa de aceitação de termos
    expect(find.textContaining('Muito bem!'), findsOneWidget);
  });

  testWidgets(
      'Botão "Continuar" deve estar desabilitado se nenhuma opção for selecionada',
      (WidgetTester tester) async {
    final mockQuestions = [
      QuestionModel(
        id: 'q1',
        text: 'Qual seu objetivo financeiro?',
        answers: [
          AnswerModel(id: 'a1', text: 'Economizar'),
          AnswerModel(id: 'a2', text: 'Investir'),
        ],
      ),
    ];

    when(mockQuestionsService.getAll()).thenAnswer((_) async => mockQuestions);
    when(mockUserAnswersService.submitAnswers(any)).thenAnswer((_) async {});

    await tester.pumpWidget(
      const MaterialApp(home: ProfileFlowPage()),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Concordar e Continuar'));
    await tester.pumpAndSettle();

    final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Continuar'));
    expect(button.onPressed, isNull);
  });
}
