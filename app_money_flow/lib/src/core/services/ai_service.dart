import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  final String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  final String apiKey;

  /// Histórico da conversa com a IA
  final List<Map<String, String>> _messageHistory = [
    {
      "role": "system",
      "content": "Você é um assistente financeiro chamado MoneyFlow AI. Responda de forma clara e útil."
    }
  ];

  AiService({required this.apiKey});

  Future<String> getCompletion(String userMessage) async {
    // Adiciona a pergunta do usuário ao histórico
    _messageHistory.add({"role": "user", "content": userMessage});

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://appmoneyflow.com',
        'X-Title': 'MoneyFlow Chat AI',
      },
      body: jsonEncode({
        "model": "deepseek/deepseek-chat-v3-0324", 
        "messages": _messageHistory,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final reply = data['choices'][0]['message']['content'] as String;

      // Adiciona a resposta da IA ao histórico
      _messageHistory.add({"role": "assistant", "content": reply});

      return reply;
    } else {
      throw Exception('Erro ao buscar resposta da IA');
    }
  }

  /// Limpa o histórico da conversa (se necessário, por exemplo, ao finalizar uma sessão)
  void clearHistory() {
    _messageHistory.clear();
    _messageHistory.add({
      "role": "system",
      "content": "Você é um assistente financeiro chamado MoneyFlow AI. Responda de forma clara e útil."
    });
  }
}
