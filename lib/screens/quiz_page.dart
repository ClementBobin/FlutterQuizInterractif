import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;

  const QuizPage({Key? key, required this.questions}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.pushNamed(context, '/results', arguments: _score);
    }
  }

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == widget.questions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }
    _nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.questionText,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ...question.options.asMap().entries.map((entry) {
              int idx = entry.key;
              String option = entry.value;
              return ElevatedButton(
                onPressed: () => _answerQuestion(idx),
                child: Text(option),
              );
            }).toList(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
