import 'package:flutter/material.dart';
import 'package:teknofest/giris_sorulari/sayi_oyunu.dart';

import 'package:teknofest/other_functions/game_manager.dart';

//Bu ekranda, sıradaki oyun otomatik olarak başlayacak ve kullanıcı "Skip" düğmesine basarak bir sonraki oyuna geçebilecek.

class GirisSorulariScreen extends StatefulWidget {
  const GirisSorulariScreen({super.key});

  @override
  _GirisSorulariScreenState createState() => _GirisSorulariScreenState();
}

class _GirisSorulariScreenState extends State<GirisSorulariScreen> {
  late GameManager _manager;

  @override
  void initState() {
    super.initState();
    _manager = GameManager();
    _startNextGame();
  }

  // void _startNextGame() {
  //   final nextGameRoute = _manager.getNextGame();
  //   if (nextGameRoute != null) {
  //     Navigator.pushReplacementNamed(context, nextGameRoute);
  //   } else {
  //     _onAllGamesCompleted();
  //   }
  // }
  // void _startNextGame() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final nextGameRoute = _manager.getNextGame();
  //     if (nextGameRoute != null) {
  //       Navigator.pushReplacementNamed(context, nextGameRoute);
  //     } else {
  //       _onAllGamesCompleted();
  //     }
  //   });
  // }
  void _startNextGame() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final nextGameRoute = _manager.getNextGame();
      print('Next game route: $nextGameRoute');
      // if (nextGameRoute != null) {
      //   Navigator.pushReplacementNamed(context, nextGameRoute);
      // }
      if (nextGameRoute != null) {
        // Ekranı yönlendir
        final result = await Navigator.pushNamed(context, nextGameRoute);
        if (result == true) {
          _startNextGame(); // Eğer oyun tamamlanmışsa, bir sonraki oyuna geç
        } else {
          _onAllGamesCompleted();
        }
      }
    });
  }

  void _onAllGamesCompleted() {
    Navigator.pushReplacementNamed(context, '/etkinlik_sorulari_list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giris Sorulari'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startNextGame,
          child: const Text('Skip'),
        ),
      ),
    );
  }
}
