import 'dart:convert';
import 'package:app_money_flow/src/core/models/user_answers_model.dart';
import 'package:app_money_flow/src/core/services/http/http_client.dart';

class UserAnswersService {
  final HttpClient http;

  UserAnswersService(this.http);

  Future<dynamic> submitAnswers(List<UserAnswerModel> answers) async {
    final body = jsonEncode(
      answers.map((a) => a.toJson()).toList(),
    );
    await http.post('/user-answers', body: body);
  }
}
