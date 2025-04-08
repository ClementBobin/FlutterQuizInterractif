import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/question.dart';
import 'results_page.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;

  const QuizPage({Key? key, required this.questions}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int> _selectedIndices = [];
  late AudioPlayer _correctSoundPlayer;
  late AudioPlayer _wrongSoundPlayer;

  @override
  void initState() {
    super.initState();
    _initAudioPlayers();
  }

  Future<void> _initAudioPlayers() async {
    _correctSoundPlayer = AudioPlayer();
    _wrongSoundPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _correctSoundPlayer.dispose();
    _wrongSoundPlayer.dispose();
    super.dispose();
  }

  Future<void> _playCorrectAnswerFeedback() async {
    try {
      // play sound
      await _correctSoundPlayer.play(AssetSource('correct_answer.mp3'));
      // vibrate with medium impact for correct answer
      HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('error playing correct sound: $e');
    }
  }

  Future<void> _playWrongAnswerFeedback() async {
    try {
      // play sound
      await _wrongSoundPlayer.play(AssetSource('wrong_answer.mp3'));
      // vibrate with heavy impact for wrong answer
      HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint('error playing wrong sound: $e');
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedIndices = [];
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(score: _score, totalQuestions: widget.questions.length, questions: widget.questions),
        ),
      );
    }
  }

  void _answerQuestion() {
    final correctAnswers = widget.questions[_currentQuestionIndex].correctAnswerIndices;
    if (_selectedIndices.toSet().containsAll(correctAnswers) && correctAnswers.toSet().containsAll(_selectedIndices)) {
      _score++;
      _playCorrectAnswerFeedback();
    } else {
      _playWrongAnswerFeedback();
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
            SizedBox(height: 10.0),
            Text(
              'Difficulty: ${question.difficulty}',
              style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20.0),
            ...question.options.asMap().entries.map((entry) {
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
              onPressed: _answerQuestion,
              child: const Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
