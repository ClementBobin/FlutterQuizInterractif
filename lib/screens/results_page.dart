import 'package:flutter/material.dart';
import 'quiz_page.dart';

class ResultsPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int quizId;

  const ResultsPage({Key? key, required this.score, required this.totalQuestions, required this.quizId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String feedback;
    if (score == totalQuestions) {
      feedback = 'Excellent!';
    } else if (score > totalQuestions / 2) {
      feedback = 'Good job!';
    } else {
      feedback = 'Better luck next time!';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your score is $score/$totalQuestions',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              feedback,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(quizId: quizId, quizCountOfQuestions: totalQuestions),
                  ),
                );
              },
              child: const Text('Restart Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Return Home'),
            ),
          ],
        ),
      ),
    );
  }
}