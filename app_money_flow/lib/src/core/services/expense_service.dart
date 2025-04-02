import 'dart:convert';
import 'package:flutter/services.dart'; // Para ler arquivos locais
import 'package:app_money_flow/src/core/models/transaction.dart'; // Ajuste o caminho conforme necessário

class ExpenseService {
  // Função para buscar as transações a partir de um arquivo local
  Future<List<Transaction>> fetchTransactions() async {
    try {
      // Carregar o arquivo JSON
      final String response = await rootBundle.loadString(
        'data/transactions.json',
      );

      // Converter o JSON para uma lista de objetos
      List<dynamic> data = json.decode(response);

      // Converter os dados em uma lista de Transaction
      return data.map((json) => Transaction.fromJson(json)).toList();
    } catch (e) {
      // Caso ocorra um erro, você pode lançar uma exceção personalizada ou retornar uma lista vazia
      print('Erro ao carregar as transações: $e');
      return []; // Retorna uma lista vazia caso haja erro
    }
  }
}
