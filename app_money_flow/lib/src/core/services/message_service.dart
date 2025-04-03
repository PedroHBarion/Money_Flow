import 'dart:convert';
import 'package:flutter/services.dart';

/// Classe responsável por gerenciar as mensagens associadas a diferentes categorias de despesas.
class MessageService {
  /// Mapa que armazena as mensagens associadas a cada categoria.
  Map<String, String> _messages = {};

  /// Construtor que carrega as mensagens ao inicializar a classe.
  MessageService() {
    _loadMessages();
  }

  /// Carrega as mensagens a partir de um arquivo JSON localizado na pasta 'data/messages.json'.
  /// O arquivo JSON deve conter um mapa onde as chaves são categorias e os valores são as mensagens correspondentes.
  Future<void> _loadMessages() async {
    try {
      // Lê o conteúdo do arquivo JSON
      final String response = await rootBundle.loadString('assets/data/messages.json');

      // Decodifica o JSON para um mapa dinâmico
      Map<String, dynamic> data = json.decode(response);

      // Converte os valores do mapa para strings e armazena no atributo _messages
      _messages = data.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      print("Erro ao carregar mensagens: $e");
    }
  }

  /// Retorna a mensagem associada à categoria fornecida.
  /// Se as mensagens ainda não foram carregadas, ele carrega primeiro.
  /// Caso a categoria não tenha uma mensagem correspondente, retorna uma mensagem padrão.
  Future<String> getMessageForCategory(String category) async {
    // Garante que as mensagens estejam carregadas antes de acessar o mapa
    if (_messages.isEmpty) {
      await _loadMessages();
    }

    // Retorna a mensagem da categoria ou uma mensagem padrão se não existir
    return _messages[category] ?? "Nenhuma mensagem disponível para essa categoria.";
  }
}
