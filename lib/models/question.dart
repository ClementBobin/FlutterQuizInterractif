class Question {
  final String questionText;
  final List<String> options;
  final List<int> correctAnswerIndices;
  final String difficulty;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndices,
    required this.difficulty,
  });
}