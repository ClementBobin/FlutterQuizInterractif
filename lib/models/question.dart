class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? difficulty;
  final List<int>? correctAnswerIndices;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.difficulty,
    this.correctAnswerIndices,
  });
}
