// import 'package:flutter/material.dart';
// import 'dart:async';

// class WordFillGame extends StatefulWidget {
//   const WordFillGame({super.key});

//   @override
//   _WordFillGameState createState() => _WordFillGameState();
// }

// class _WordFillGameState extends State<WordFillGame> {
//   final List<Map<String, String>> items = [
//     {'emoji': '🪟', 'word': ' ', 'answer': 'pencere'},
//     {'emoji': '👓', 'word': ' ', 'answer': 'gözlük'},
//     {'emoji': '🐕', 'word': ' ', 'answer': 'köpek'},
//     {'emoji': '🍦', 'word': ' ', 'answer': 'dondurma'},
//     {'emoji': '🍉', 'word': ' ', 'answer': 'karpuz'},
//   ];

//   final List<TextEditingController> controllers = [];
//   final List<List<String>> correctLetters = [];
//   final List<List<String>> userLetters = [];
//   final List<Color> colors = [];

//   final List<String> alphabet = 'abcçdefgğhıijklmnoöprsştuüvyz'.split('');

//   Timer? _timer;
//   int _start = 200; // Örnek olarak süreyi 10 saniye olarak ayarladım
//   bool _gameOver = false;
//   int _completedCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     for (var i = 0; i < items.length; i++) {
//       controllers.add(TextEditingController());
//       colors.add(Colors.transparent);

//       correctLetters.add(items[i]['answer']!.split(''));
//       userLetters.add(List.filled(items[i]['answer']!.length,
//           '')); // Boş kutucuklar için kullanıcı harfleri
//     }

//     // Oyun zamanlayıcısını başlat
//     _startTimer();
//   }

//   void _startTimer() {
//     const oneSecond = Duration(seconds: 1);
//     _timer = Timer.periodic(oneSecond, (Timer timer) {
//       if (_start == 0) {
//         _timer!.cancel();
//         // Süre bittiğinde oyunu kontrol et ve gerekiyorsa bitir
//         if (!_gameOver) {
//           _handleGameEnd();
//         }
//       } else {
//         setState(() {
//           _start--;

//         });
//       }
//     });
//   }

//   // void checkAnswer(int index) {
//   //   // Onaylama tuşuna basıldığında işlem yap
//   //   if (!_gameOver && colors[index] == Colors.transparent) {
//   //     String userAnswer =
//   //         userLetters[index].join('').toLowerCase().replaceAll(' ', '');
//   //     String correctAnswer = items[index]['answer']!.toLowerCase();
//   //     if (userAnswer == correctAnswer) {
//   //       colors[index] = Colors.green.withOpacity(0.3);
//   //     } else {
//   //       colors[index] = Colors.red.withOpacity(0.3);
//   //     }
//   //     _completedCount++;

//   //     if (_completedCount == items.length) {
//   //       _handleGameEnd();
//   //     }
//   //   }
//   // }

//   void checkAnswer(int index) {
//   if (!_gameOver && colors[index] == Colors.transparent) {
//     String userAnswer = userLetters[index].join('').toLowerCase().replaceAll(' ', '');
//     String correctAnswer = items[index]['answer']!.toLowerCase();
//     if (userAnswer == correctAnswer) {
//       colors[index] = Colors.green.withOpacity(0.3);
//     } else {
//       colors[index] = Colors.red.withOpacity(0.3);
//     }
//     _completedCount++;

//     if (_completedCount == items.length) {
//       _handleGameEnd();
//     }
//   }
// }

//   void _handleGameEnd() {
//     // Oyun bittiğinde yapılacak işlemler buraya yazılabilir
//     // _gameOver = true;
//     // Navigator.of(context).pop(); // Geriye dönerek uygulamadan çık
//       _gameOver = true;
//   Navigator.pop(context, true); // true veya herhangi bir değer döndürebilirsiniz
//   }

//   @override
//   void dispose() {
//     _timer!.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Görselin adını harfleri sıralayarak bul.'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               items[index]['emoji']!,
//                               style: const TextStyle(fontSize: 40),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Wrap(
//                                 spacing: 8.0,
//                                 runSpacing: 8.0,
//                                 children: List.generate(
//                                   correctLetters[index].length,
//                                   (letterIndex) {
//                                     String correctLetter =
//                                         correctLetters[index][letterIndex];
//                                     return DragTarget<String>(
//                                       builder: (BuildContext context,
//                                           List<String?> incoming,
//                                           List<dynamic> rejected) {
//                                         return Container(
//                                           height: 50,
//                                           width: 50,
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                             color: colors[index] !=
//                                                     Colors.transparent
//                                                 ? colors[index]
//                                                 : (incoming.isEmpty
//                                                     ? Colors.blue
//                                                     : Colors.blue[200]),
//                                             borderRadius:
//                                                 BorderRadius.circular(8.0),
//                                           ),
//                                           child: Text(
//                                             userLetters[index][letterIndex],
//                                             style: const TextStyle(
//                                                 fontSize: 24,
//                                                 color: Color.fromARGB(
//                                                     255, 255, 255, 253)),
//                                           ),
//                                         );
//                                       },
//                                       onWillAcceptWithDetails: (details) =>
//                                           true,
//                                       onAcceptWithDetails: (details) {
//                                         setState(() {
//                                           userLetters[index][letterIndex] =
//                                               details.data as String;
//                                         });
//                                       },
//                                     );
//                                   },
//                                 ).toList(),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () => checkAnswer(index),
//                               child: const Text('Onayla'),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         const Divider(),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const Text(
//               'Harf Havuzu (tut-sürükle-bırak)',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: List.generate(
//                 alphabet.length,
//                 (index) => Draggable<String>(
//                   data: alphabet[index],
//                   feedback: Material(
//                     color: Colors.blue.withOpacity(0.7),
//                     elevation: 4.0,
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Container(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         alphabet[index],
//                         style:
//                             const TextStyle(fontSize: 24, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   child: Material(
//                     color: Colors.blue.withOpacity(0.2),
//                     elevation: 4.0,
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Container(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         alphabet[index],
//                         style:
//                             const TextStyle(fontSize: 24, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   onDragCompleted: () {
//                     // Optional: Add custom logic when dragging is completed
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Kalan Süre: $_start sn',
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:async';

class WordFillGame extends StatefulWidget {
  const WordFillGame({super.key});

  @override
  _WordFillGameState createState() => _WordFillGameState();
}

class _WordFillGameState extends State<WordFillGame> {
  final List<Map<String, String>> items = [
    {'emoji': '🪟', 'word': ' ', 'answer': 'pencere'},
    {'emoji': '👓', 'word': ' ', 'answer': 'gözlük'},
    {'emoji': '🐕', 'word': ' ', 'answer': 'köpek'},
    {'emoji': '🍦', 'word': ' ', 'answer': 'dondurma'},
    {'emoji': '🍉', 'word': ' ', 'answer': 'karpuz'},
  ];

  final List<TextEditingController> controllers = [];
  final List<List<String>> correctLetters = [];
  final List<List<String>> userLetters = [];
  final List<Color> colors = [];

  final List<String> alphabet = 'abcçdefgğhıijklmnoöprsştuüvyz'.split('');

  Timer? _timer;
  int _start = 200; // Örnek olarak süreyi 200 saniye olarak ayarladım
  bool _gameOver = false;
  int _completedCount = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < items.length; i++) {
      controllers.add(TextEditingController());
      colors.add(Colors.transparent);

      correctLetters.add(items[i]['answer']!.split(''));
      userLetters.add(List.filled(items[i]['answer']!.length,
          '')); // Boş kutucuklar için kullanıcı harfleri
    }

    // Oyun zamanlayıcısını başlat
    _startTimer();
  }

  void _handleGameEnd() {
    _gameOver = true;
    Navigator.pop(
        context, true); // true veya herhangi bir değer döndürebilirsiniz
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (_start == 0) {
        _timer!.cancel();
        // Süre bittiğinde oyunu kontrol et ve gerekiyorsa bitir
        if (!_gameOver) {
          _handleGameEnd();
        }
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void checkAnswer(int index) {
    if (!_gameOver && colors[index] == Colors.transparent) {
      String userAnswer =
          userLetters[index].join('').toLowerCase().replaceAll(' ', '');
      String correctAnswer = items[index]['answer']!.toLowerCase();
      if (userAnswer == correctAnswer) {
        colors[index] = Colors.green.withOpacity(0.3);
      } else {
        colors[index] = Colors.red.withOpacity(0.3);
      }
      _completedCount++;

      // Eğer tüm sorular tamamlandıysa
      if (_completedCount == items.length) {
        _handleGameEnd();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Görselin adını harfleri sıralayarak bul.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              items[index]['emoji']!,
                              style: const TextStyle(fontSize: 40),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: List.generate(
                                  correctLetters[index].length,
                                  (letterIndex) {
                                    String correctLetter =
                                        correctLetters[index][letterIndex];
                                    return DragTarget<String>(
                                      builder: (BuildContext context,
                                          List<String?> incoming,
                                          List<dynamic> rejected) {
                                        return Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: colors[index] !=
                                                    Colors.transparent
                                                ? colors[index]
                                                : (incoming.isEmpty
                                                    ? Colors.blue
                                                    : Colors.blue[200]),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            userLetters[index][letterIndex],
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 253)),
                                          ),
                                        );
                                      },
                                      onWillAcceptWithDetails: (details) =>
                                          true,
                                      onAcceptWithDetails: (details) {
                                        setState(() {
                                          userLetters[index][letterIndex] =
                                              details.data as String;
                                        });
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () => checkAnswer(index),
                              child: const Text('Onayla'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Text(
              'Harf Havuzu (tut-sürükle-bırak)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                alphabet.length,
                (index) => Draggable<String>(
                  data: alphabet[index],
                  feedback: Material(
                    color: Colors.blue.withOpacity(0.7),
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        alphabet[index],
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  child: Material(
                    color: Colors.blue.withOpacity(0.2),
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        alphabet[index],
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  onDragCompleted: () {
                    // Optional: Add custom logic when dragging is completed
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Kalan Süre: $_start sn',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
