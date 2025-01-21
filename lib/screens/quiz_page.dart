import 'package:flutter/material.dart';
import '../models/question.dart';
import 'results_page.dart';
import '../http/http_request_session.dart';
import '../http/api_prepare_requests.dart';
import 'dart:convert';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int> _selectedIndices = [];
  Question? _currentQuestion;
  bool _isLoading = true;
  final Session _session = Session();

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  Future<void> _fetchQuestion() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await makeRequest(_session, 'GET', 'http://127.0.0.1:8000/api/question/$_currentQuestionIndex');
      setState(() {
        _currentQuestion = Question.fromJson(response);
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load question: $e');
    }
  }

  Future<void> _submitAnswer() async {
    final response = await makeRequest(
      _session,
      'POST',
      'http://127.0.0.1:8000/api/submit',
      body: jsonEncode({
        'questionIndex': _currentQuestion!.id,
        'selectedIndices': _selectedIndices,
      }),
    );

    setState(() {
      _score = _score + (response['score'] as int);
    });
    

    _nextQuestion();
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < 4) { // Assuming there are 5 questions
      setState(() {
        _currentQuestionIndex++;
        _selectedIndices = [];
      });
      _fetchQuestion();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(score: _score, totalQuestions: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
              _currentQuestion!.questionText,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Difficulty: ${_currentQuestion!.difficulty}',
              style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20.0),
            ..._currentQuestion!.options.asMap().entries.map((entry) {
              int idx = entry.key;
              String option = entry.value;
              return CheckboxListTile(
                title: Text(option),
                value: _selectedIndices.contains(idx),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedIndices.add(idx);
                    } else {
                      _selectedIndices.remove(idx);
                    }
                  });
                },
              );
            }).toList(),
            ElevatedButton(
              onPressed: _submitAnswer,
              child: const Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }
}