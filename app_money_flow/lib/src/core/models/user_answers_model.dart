class UserAnswerModel {
  final String questionId;
  final String answerId;

  UserAnswerModel({
    required this.questionId,
    required this.answerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answerId': answerId,
    };
  }
}
