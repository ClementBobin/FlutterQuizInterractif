import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz/screens/results_page.dart';

void main() {
  testWidgets('ResultsPage displays the final score and feedback', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ResultsPage(score: 4, totalQuestions: 5),
      ),
    );

    expect(find.text('Your score is 4/5'), findsOneWidget);
    expect(find.text('Good job!'), findsOneWidget);
  });

  testWidgets('ResultsPage navigation buttons work', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ResultsPage(score: 4, totalQuestions: 5),
      ),
    );

    expect(find.text('Restart Quiz'), findsOneWidget);
    expect(find.text('Return Home'), findsOneWidget);

    await tester.tap(find.text('Restart Quiz'));
    await tester.pumpAndSettle();
    expect(find.text('Your score is 4/5'), findsNothing);

    await tester.tap(find.text('Return Home'));
    await tester.pumpAndSettle();
    expect(find.text('Your score is 4/5'), findsNothing);
  });
}
