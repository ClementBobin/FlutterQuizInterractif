// lib/main.dart

import 'package:flutter/material.dart';
import 'models/question.dart';
import 'screens/quiz_page.dart';

final List<Question> sampleQuestions = [
  Question(
    questionText: 'What is Flutter?',
    options: ['A bird', 'A mobile development framework', 'A type of dance', 'A programming language'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which language is used to write Flutter apps?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the purpose of the pubspec.yaml file?',
    options: ['To define app dependencies', 'To write app code', 'To design app UI', 'To test the app'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which widget is used to create a button in Flutter?',
    options: ['Text', 'Container', 'Column', 'ElevatedButton'],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the use of the setState() method in Flutter?',
    options: ['To update the UI', 'To navigate between screens', 'To handle user input', 'To manage app state'],
    correctAnswerIndex: 0,
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Quiz Home Page'),
      routes: {
        '/quiz': (context) => QuizPage(questions: sampleQuestions),
        // Add other routes here
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            Navigator.pushNamed(context, '/quiz');
          },
          child: Text('Start Quiz'),
        ),
      ),
    );
  }
}