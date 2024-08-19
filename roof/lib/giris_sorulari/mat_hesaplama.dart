import 'package:flutter/material.dart';


class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  List<Map<String, dynamic>> equations = [
    {'equation': '1 + ? = 3', 'result': 2},
    {'equation': '2 x ? = 10', 'result': 5},
    {'equation': '3 + ? = 5', 'result': 2},
    {'equation': '9 - ? = 3', 'result': 6},
    {'equation': '7 + ? = 11', 'result': 4},
  ];

  List<int> results = [2, 5, 2, 6, 4];
  List<bool> matched = List.filled(5, false);
  List<Color> equationColors = List.filled(5, const Color.fromARGB(255, 223, 4, 4));
  List<Color> resultColors = List.filled(5, const Color.fromARGB(255, 225, 7, 7));
  List<bool> disabled = List.filled(5, false);
  List<bool> completed = List.filled(5, false); // Yeni eklenen liste

  int correctCount = 0;
  int wrongCount = 0;
  bool gameEnded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matematik Oyunu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: equations.length,
              itemBuilder: (context, index) {
                return DragTarget<int>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/tahta.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          equations[index]['equation'],
                          style: TextStyle(
                            color: const Color.fromARGB(255, 37, 0, 244),
                            fontSize: 18,
                            decoration: disabled[index]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      height: 50,
                      width: 100,
                    );
                  },
                  onWillAcceptWithDetails: (data) => !disabled[index],
                  onAcceptWithDetails: (data) {
                    if (!completed[index]) {
                      // Tamamlanmamışsa devam et
                      if (data == equations[index]['result']) {
                        setState(() {
                          matched[index] = true;
                          disabled[index] = true;
                          completed[index] = true; // Denklem tamamlandı işareti
                          if (equationColors[index] != Colors.red) {
                            equationColors[index] = Colors.green;
                          }
                          correctCount++;
                          checkGameEnd();
                        });
                      } else {
                        setState(() {
                          equationColors[index] = Colors.red;
                          completed[index] = true; // Denklem tamamlandı işareti
                          wrongCount++;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Hatalı eşleştirme'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ),
          Container(
            height: 100,
            color: const Color.fromARGB(68, 194, 81, 196),
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Draggable<int>(
                  data: results[index],
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/box.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          results[index].toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 176, 25, 25),
                              fontSize: 18),
                        ),
                      ),
                      height: 50,
                      width: 100,
                    ),
                  ),
                  childWhenDragging: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        results[index].toString(),
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ),
                    height: 50,
                    width: 100,
                  ),
                  feedbackOffset: const Offset(0, -30),
                  onDragCompleted: () {
                    setState(() {
                      resultColors[index] = const Color.fromARGB(255, 0, 190, 232);
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/box.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        results[index].toString(),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 195, 44, 44),
                          fontSize: 18,
                          decoration: matched[index]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    height: 50,
                    width: 100,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: gameEnded,
            child: Column(
              children: [
                Text(
                  'Toplam Doğru: $correctCount',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Toplam Yanlış: $wrongCount',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: gameEnded
                ? null
                : () {
                    setState(() {
                      gameEnded = true;
                    });
                  },
            child: const Text('Oyunu Bitir'),
          ),
        ],
      ),
    );
  }

  void checkGameEnd() {
    bool allMatched = true;
    for (int i = 0; i < matched.length; i++) {
      if (!matched[i]) {
        allMatched = false;
        break;
      }
    }
    if (allMatched) {
      setState(() {
        gameEnded = true;
      });
    }
  }
}
