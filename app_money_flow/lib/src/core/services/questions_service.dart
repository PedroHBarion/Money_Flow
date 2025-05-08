import 'dart:convert';
import 'package:app_money_flow/src/core/models/questions_model.dart';
import 'package:app_money_flow/src/core/services/http/http_client.dart';

class QuestionsService {
  final HttpClient http;

  QuestionsService(this.http);

  Future<List<QuestionModel>> getAll() async {
    final response = await http.get('/questions');
    final List data = jsonDecode(response);
    return data.map((item) => QuestionModel.fromJson(item)).toList();
  }
}
