import 'package:app_money_flow/src/core/config/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:provider/provider.dart';

import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/services/transactions_service.dart';
import 'package:app_money_flow/src/core/services/ai_service.dart';
import 'package:app_money_flow/src/pages/chat/chat_controller.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ChatMessagesController();
  final _aiUser = ChatUser(id: 'ia', firstName: 'Assistente Financeiro');
  bool _isLoading = false;

  late final ChatController _chatController;

  @override
  void initState() {
    super.initState();

    final transactionService = getIt<TransactionService>();
    final aiService = getIt<AiService>();

    _chatController = ChatController(
      aiService: aiService,
      transactionService: transactionService,
    );
  }

  Future<void> _handleSendMessage(ChatMessage message) async {
    // Adiciona a mensagem do usuário no chat
    _controller.addMessage(message);

    final messageId = 'stream_${DateTime.now().millisecondsSinceEpoch}';

    // Mensagem inicial da IA (vazia para começar streaming)
    final aiInitialMessage = ChatMessage(
      text: '',
      user: _aiUser,
      createdAt: DateTime.now(),
      customProperties: {'id': messageId},
    );

    _controller.addMessage(aiInitialMessage);

    setState(() {
      _isLoading = true;
    });

    try {
      // Aqui pega o nome do usuário no momento do envio
      final user = context.read<AuthProvider>().user!;
      final userName = user.name;

      // Passa o userName para o método do controller
      final response =
          await _chatController.buildContextualResponse(message.text, userName);

      String currentText = '';
      // Atualiza o texto da resposta da IA aos poucos para efeito de "streaming"
      for (int i = 0; i < response.length; i++) {
        await Future.delayed(const Duration(milliseconds: 25));
        currentText += response[i];

        final updatedMessage = aiInitialMessage.copyWith(text: currentText);
        _controller.updateMessage(updatedMessage);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String capitalizeFirstLetter(String text) {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1).toLowerCase();
    }

    final user = context.watch<AuthProvider>().user!;
    final formattedName = capitalizeFirstLetter(user.name);
    final _currentUser = ChatUser(id: formattedName, firstName: formattedName);

    return Scaffold(
      backgroundColor: Colors.white, // fundo geral branco
      appBar: AppBar(title: const Text('Assistente Financeiro')),
      body: AiChatWidget(
        currentUser: _currentUser,
        aiUser: _aiUser,
        controller: _controller,
        onSendMessage: _handleSendMessage,
        loadingConfig: LoadingConfig(
          isLoading: _isLoading,
        ),
        inputOptions: InputOptions(
          sendOnEnter: true,
          autocorrect: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white, // input branco
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: const Color(0xFF087F5B), width: 2),
            ),
          ),
        ),
        messageListOptions: MessageListOptions(),
        messageOptions: MessageOptions(
          bubbleStyle: BubbleStyle(
            userNameColor: Colors.blue,
            aiNameColor: const Color(0xFF087F5B),
          ),
          timeFormat: (dateTime) {
            return DateFormat('HH:mm', 'pt_BR').format(dateTime);
          },
        ),
        welcomeMessageConfig: const WelcomeMessageConfig(
          title: 'Bem-vindo ao seu Assistente Pessoal!',
          questionsSectionTitle: 'Experimente perguntar:',
        ),
        exampleQuestions: const [
          ExampleQuestion(question: "Como você pode me ajudar?"),
          ExampleQuestion(question: "Me fale sobre suas funcionalidades"),
        ],
        enableAnimation: true,
        enableMarkdownStreaming: true,
        streamingDuration: const Duration(milliseconds: 25),
      ),
    );
  }
}
