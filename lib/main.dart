// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scorekeeper = [];
  int score = 0;
  void checkTheResult(bool correctAns) {
    bool correctAnswer = quizBrain.getAnswer();
    int percentageScore = 0;
    setState(() {
      if (quizBrain.isFinished() == true) {
        percentageScore = ((score / quizBrain.numOfQuestions()) * 100).round();
        Alert(
                context: context,
                title: "Quiz Finished",
                desc:
                    "Congrats You Have Finished The Quiz and your score is $percentageScore %")
            .show();
        quizBrain.reset();
        scorekeeper.clear();
      } else {
        if (correctAnswer == correctAns) {
          scorekeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          score++;
        } else {
          scorekeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkTheResult(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkTheResult(false);
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}
