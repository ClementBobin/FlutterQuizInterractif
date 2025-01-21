import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz/main.dart';

void main() {
  testWidgets('Verify presence of title and button', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Interactive Quiz'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
  });

  testWidgets('Verify navigation to quiz page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    expect(find.text('Quiz Page'), findsOneWidget);
  });
}
