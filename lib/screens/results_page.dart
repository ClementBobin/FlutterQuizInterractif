import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/question.dart';
import 'quiz_page.dart';

class ResultsPage extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final List<Question> questions;

  const ResultsPage({Key? key, required this.score, required this.totalQuestions, required this.questions}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playResultSound();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playResultSound() async {
    try {
      if (widget.score == widget.totalQuestions) {
        // perfect score - play victory sound 3 times
        for (int i = 0; i < 3; i++) {
          await _audioPlayer.play(AssetSource('victory.mp3'));
          // wait for the sound to finish before playing again
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      } else if (widget.score > widget.totalQuestions / 2) {
        // good score - play victory sound 3 times
        for (int i = 0; i < 3; i++) {
          await _audioPlayer.play(AssetSource('victory.mp3'));
          // wait for the sound to finish before playing again
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      } else {
        // low score - play defeat sound once
        await _audioPlayer.play(AssetSource('defeat.mp3'));
      }
    } catch (e) {
      debugPrint('error playing result sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String feedback;
    if (widget.score == widget.totalQuestions) {
      feedback = 'Excellent!';
    } else if (widget.score > widget.totalQuestions / 2) {
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
              'Your score is ${widget.score}/${widget.totalQuestions}',
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
                    builder: (context) => QuizPage(questions: widget.questions),
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
