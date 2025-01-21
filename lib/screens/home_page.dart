import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Question> sampleQuestions = [
    Question(
      questionText: 'What is Flutter?',
      options: ['A bird', 'A mobile development framework', 'A type of dance', 'A programming language'],
      correctAnswerIndices: [1],
      difficulty: 'Easy',
    ),
    Question(
      questionText: 'Which language is used to write Flutter apps?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctAnswerIndices: [0, 1, 2],
      difficulty: 'Medium',
    ),
    Question(
      questionText: 'What is the purpose of the pubspec.yaml file?',
      options: ['To define app dependencies', 'To write app code', 'To design app UI', 'To test the app'],
      correctAnswerIndices: [0],
      difficulty: 'Easy',
    ),
    Question(
      questionText: 'Which widget is used to create a button in Flutter?',
      options: ['Text', 'Container', 'Column', 'ElevatedButton'],
      correctAnswerIndices: [3],
      difficulty: 'Easy',
    ),
    Question(
      questionText: 'What is the use of the setState() method in Flutter?',
      options: ['To update the UI', 'To navigate between screens', 'To handle user input', 'To manage app state'],
      correctAnswerIndices: [0],
      difficulty: 'Medium',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPage(questions: sampleQuestions),
              ),
            );
          },
          child: const Text('Start Quiz'),
        ),
      ),
    );
  }
}