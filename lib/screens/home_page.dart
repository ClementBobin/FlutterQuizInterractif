import 'package:flutter/material.dart';
import '../http/http_request_session.dart';
import '../http/api_prepare_requests.dart';
import 'quiz_page.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Session _session = Session();
  List<dynamic> _quizzes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuizzes();
  }

  Future<void> _fetchQuizzes() async {
    try {
      final response = await makeRequest(_session, 'GET', 'http://127.0.0.1:8000/api/quizzes');
      setState(() {
        _quizzes = response;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load quizzes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _quizzes.length,
        itemBuilder: (context, index) {
          final quiz = _quizzes[index];
          return ListTile(
            title: Text(quiz['name']),
            subtitle: Text('Difficulty: ${quiz['difficulty']}'),
            trailing: Text('Questions: ${quiz['questions_count']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(quizId: quiz['id'], quizCountOfQuestions: quiz['questions_count']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}