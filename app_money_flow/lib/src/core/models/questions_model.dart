class AnswerModel {
  final String id;
  final String text;

  AnswerModel({required this.id, required this.text});

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      id: map['id'],
      text: map['text'],
    );
  }
}

class QuestionModel {
  final String id;
  final String text;
  final List<AnswerModel> answers;

  QuestionModel({
    required this.id,
    required this.text,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      text: map['text'],
      answers: (map['answers'] as List)
          .map((a) => AnswerModel.fromMap(a))
          .toList(),
    );
  }
}
