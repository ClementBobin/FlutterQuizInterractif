import 'dart:convert';

class Question {
  final int id;
  final String questionText;
  final List<String> options;
  final String difficulty;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['question_text'],
      options: List<String>.from(jsonDecode(json['options'])),
      difficulty: json['difficulty'],
    );
  }
}