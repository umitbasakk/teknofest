import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const StartPage(),
      '/game': (context) => const FillMissingLetter(),
      '/result': (context) => const ResultPage(),
    },
  ));
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill Missing Letter Game'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/game');
          },
          child: const Text('Oyuna Başla'),
        ),
      ),
    );
  }
}

class FillMissingLetter extends StatefulWidget {
  const FillMissingLetter({super.key});

  @override
  _FillMissingLetterState createState() => _FillMissingLetterState();
}

class _FillMissingLetterState extends State<FillMissingLetter> {
  final List<Map<String, String>> wordData = [
    {"word": "pasta", "imageUrl": "assets/images/ilk_harf_img/pasta.jpg"},
    {"word": "örümcek", "imageUrl": "assets/images/ilk_harf_img/orumcek.jpg"},
    {"word": "tabak", "imageUrl": "assets/images/ilk_harf_img/tabak.jpg"},
    {"word": "bebek", "imageUrl": "assets/images/ilk_harf_img/bebek.jpg"},
    {"word": "tavuk", "imageUrl": "assets/images/ilk_harf_img/tavuk.jpg"},
    {"word": "bulut", "imageUrl": "assets/images/ilk_harf_img/bulut.jpg"},
  ];

  List<Map<String, String>> remainingWords =
      []; // Kullanılmamış kelimeler listesi
  late Map<String, String> currentWordData;
  final TextEditingController _controller = TextEditingController();
  bool isCorrect = false;
  bool isAnswered = false;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    remainingWords = List.from(wordData); // Kopyasını alıyoruz
    getNextWord(); // İlk kelimeyi seçiyoruz
  }
  //nerede çağıracağımı bulamadım
  void _handleGameEnd() {
    setState(() {
      _gameOver = true;
    });
    // Navigator.pushReplacementNamed(context, '/result'); // Sonuç sayfasına geçiş
  }

  void getNextWord() {
    setState(() {
      if (remainingWords.isEmpty) {
        // Eğer kalan kelimeler listesi boşsa, oyunu bitir ve sonuç sayfasına git
        // Navigator.pushReplacementNamed(context, '/result');
        _handleGameEnd();
      } else {
        // Rastgele bir sonraki kelimeyi seç
        int randomIndex = Random().nextInt(remainingWords.length);
        currentWordData = remainingWords[randomIndex];
        remainingWords.removeAt(randomIndex); // Seçilen kelimeyi listeden çıkar
        _controller.clear();
        isAnswered = false;
        isCorrect = false;
      }
    });
  }

  void checkAnswer() {
    setState(() {
      isAnswered = true;
      isCorrect = _controller.text.toLowerCase() == currentWordData["word"]![0];
    });

    if (isCorrect) {
      Future.delayed(const Duration(seconds: 1), () {
        getNextWord();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boşluğa doğru harfi yaz."),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Boşluğa doğru harfi yaz:",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Image.asset(
                currentWordData["imageUrl"]!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                "_${currentWordData["word"]!.substring(1)}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Eksik harfi yaz",
                ),
                maxLength: 1,
                textCapitalization: TextCapitalization.none,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
                enabled: !isAnswered || isCorrect,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkAnswer,
                child: const Text("Onayla"),
              ),
              if (isAnswered && !isCorrect)
                ElevatedButton(
                  onPressed: getNextWord,
                  child: const Text("Sıradaki Soru"),
                ),
              if (isAnswered && !isCorrect)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Yanlış! Doğru harf: '${currentWordData["word"]![0]}'.",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sonuç ekranı için geçici veri
    int totalScore = 100;
    int totalQuestions = 6; // Toplam soru sayısı
    int correctAnswers = 5; // Doğru cevap sayısı
    int incorrectAnswers =
        totalQuestions - correctAnswers; // Yanlış cevap sayısı

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonuç'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sonuçlar:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text('Toplam Puan: $totalScore'),
            Text('Toplam Soru Sayısı: $totalQuestions'),
            Text('Doğru Cevap Sayısı: $correctAnswers'),
            Text('Yanlış Cevap Sayısı: $incorrectAnswers'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Ana Sayfa'),
            ),
          ],
        ),
      ),
    );
  }
}
