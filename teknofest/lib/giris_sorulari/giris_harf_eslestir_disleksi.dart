import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange
  ];
  final List<String> letters = ['d', 'b', 'm', 'n', 'u', 'ö'];
  final Map<String, Color> letterToColorMap = {};
  final Map<String, bool> correctMatches = {};
  int correctCount = 0;
  int incorrectCount = 0;
    bool _gameOver = false;

  List<String> shuffledLetters = [];

  @override
  void initState() {
    super.initState();
    shuffledLetters = List.from(letters)..shuffle(Random());
    for (int i = 0; i < letters.length; i++) {
      letterToColorMap[letters[i]] = Colors.transparent; // Baloncuklar başlangıçta renksiz
      correctMatches[letters[i]] = false;
    }
  }
  void _handleGameEnd() {
    _gameOver = true;
    Navigator.pop(
        context, true); // true veya herhangi bir değer döndürebilirsiniz
  }

  void _checkGameCompletion() {
    if (correctCount == letters.length) {
      _showScoreDialog();
_handleGameEnd();
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oyun Bitti!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Doğru: $correctCount'),
              Text('Yanlış: $incorrectCount'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tekrar Oyna'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      correctCount = 0;
      incorrectCount = 0;
      shuffledLetters.shuffle(Random());
      for (var letter in letters) {
        letterToColorMap[letter] = Colors.transparent;
        correctMatches[letter] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Box Coloring Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Harfleri birbiriyle eşleştiriniz.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20), // Yazı ile draggable harfler arasındaki boşluk
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: letters.map((letter) {
              return Draggable<String>(
                data: letter,
                feedback: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: colors[letters.indexOf(letter)],
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey,
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  color: colors[letters.indexOf(letter)],
                  child: Center(
                    child: Text(
                      letter,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(20),
              children: shuffledLetters.map((letter) {
                return DragTarget<String>(
                  onWillAcceptWithDetails: (receivedLetter) =>
                  !correctMatches[letter]!, // Doğru renkteki kutucuğa sadece bir kez kabul edilecek
                  onAcceptWithDetails: (receivedLetter) {
                    setState(() {
                      if (letter == receivedLetter) {
                        correctMatches[letter] = true;
                        letterToColorMap[letter] = colors[letters.indexOf(letter)];
                        correctCount++;
                      } else {
                        incorrectCount++;
                      }
                      _checkGameCompletion(); // Oyun tamamlandı mı kontrol et
                    });
                  },
                  builder: (context, acceptedItems, rejectedItems) {
                    return CircleAvatar(
                      backgroundColor: correctMatches[letter]! ? colors[letters.indexOf(letter)] : Colors.transparent,
                      radius: 3, // Baloncuk boyutunu küçültmek için radius değerini küçültüyoruz
                      child: Center(
                        child: Text(
                          letter,
                          style: const TextStyle(fontSize: 18), // Yazi boyutunu da küçültüyoruz
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Doğru: $correctCount'),
                  Text('Yanlış: $incorrectCount'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}