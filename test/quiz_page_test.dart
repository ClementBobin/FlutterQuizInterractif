import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz/screens/quiz_page.dart';
import 'package:flutter_quiz/models/question.dart';

void main() {
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

  testWidgets('QuizPage displays the first question', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: QuizPage(questions: sampleQuestions)));

    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('A bird'), findsOneWidget);
    expect(find.text('A mobile development framework'), findsOneWidget);
    expect(find.text('A type of dance'), findsOneWidget);
    expect(find.text('A programming language'), findsOneWidget);
  });

  testWidgets('QuizPage navigates to the next question on button press', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: QuizPage(questions: sampleQuestions)));

    await tester.tap(find.text('A mobile development framework'));
    await tester.pump();

    expect(find.text('Which language is used to write Flutter apps?'), findsOneWidget);
  });

  testWidgets('QuizPage calculates score correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: QuizPage(questions: sampleQuestions)));

    await tester.tap(find.text('A mobile development framework'));
    await tester.pump();
    await tester.tap(find.text('Dart'));
    await tester.pump();
    await tester.tap(find.text('To define app dependencies'));
    await tester.pump();
    await tester.tap(find.text('ElevatedButton'));
    await tester.pump();
    await tester.tap(find.text('To update the UI'));
    await tester.pump();

    expect(find.text('Score: 5'), findsOneWidget);
  });

  testWidgets('QuizPage navigates to results page after final question', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: QuizPage(questions: sampleQuestions),
      routes: {
        '/results': (context) => Scaffold(body: Text('Results Page')),
      },
    ));

    await tester.tap(find.text('A mobile development framework'));
    await tester.pump();
    await tester.tap(find.text('Dart'));
    await tester.pump();
    await tester.tap(find.text('To define app dependencies'));
    await tester.pump();
    await tester.tap(find.text('ElevatedButton'));
    await tester.pump();
    await tester.tap(find.text('To update the UI'));
    await tester.pump();

    expect(find.text('Results Page'), findsOneWidget);
  });
}
