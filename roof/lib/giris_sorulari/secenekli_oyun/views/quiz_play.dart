import 'package:flutter/material.dart';
import 'package:roof/giris_sorulari/secenekli_oyun/data/data.dart';
import 'package:roof/giris_sorulari/secenekli_oyun/model/questionmodel.dart';
import 'package:roof/giris_sorulari/secenekli_oyun/views/result.dart';


class QuizPlay extends StatefulWidget {
  const QuizPlay({super.key});

  @override
  State<QuizPlay> createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay>
    with SingleTickerProviderStateMixin {
  List<QuestionModel> _questions = [];
  int index = 0;
  int points = 0;
  int correct = 0;
  int incorrect = 0;
  int notAttempted = 0;
  late Animation animation;
  late AnimationController animationController;
  double beginAnim = 0.0;
  double endAnim = 1.0;

  @override
  void initState() {
    super.initState();
    _questions = getQuestion();
    animationController =
    AnimationController(duration: const Duration(seconds: 10), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    animation =
        Tween(begin: beginAnim, end: endAnim).animate(animationController);
    startAnim();
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (index < _questions.length - 1) {
            index++;
            resetAnim();
            startAnim();
            notAttempted++;
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Result(
                      score: points,
                      totalQuestion: _questions.length,
                      correct: correct,
                      incorrect: incorrect,
                      notAttempted: notAttempted,
                    )));
          }
        });
      }
    });
  }

  startAnim() {
    animationController.forward();
  }

  resetAnim() {
    animationController.reset();
  }

  stopAnim() {
    animationController.stop();
  }

  void checkAnswer(String selectedAnswer) {
    if (_questions[index].getAnswer() == selectedAnswer) {
      setState(() {
        points += 20;
        correct++;
      });
    } else {
      setState(() {
        points -= 5;
        incorrect++;
      });
    }

    if (index < _questions.length - 1) {
      setState(() {
        index++;
        resetAnim();
        startAnim();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            score: points,
            totalQuestion: _questions.length,
            correct: correct,
            incorrect: incorrect,
            notAttempted: notAttempted,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${index + 1}/${_questions.length}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Question",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  Text(
                    "$points",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Points",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${_questions[index].question}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: animation.value,
            ),
            const SizedBox(height: 20),
            Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.8,
              child: Image.asset(
                _questions[index].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () => checkAnswer("b"),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Text(
                          "b",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => checkAnswer("d"),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Text(
                          "d",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
