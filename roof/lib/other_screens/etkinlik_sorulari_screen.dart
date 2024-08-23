import 'package:flutter/material.dart';
//Giriş soruları tamamlandıktan sonra, kullanıcıya etkinlik sorularını sunacak bir ekran 
class EtkinlikSorulariListScreen extends StatelessWidget {
  const EtkinlikSorulariListScreen({super.key});

  final List<String> etkinlikOyunlari = const [
    'etkinlik_sorulari/disgrafi1',
    'etkinlik_sorulari/disgrafi2',
    'etkinlik_sorulari/disgrafi3',
    'etkinlik_sorulari/disgrafi4',
    'etkinlik_sorulari/disgrafi5',
    'etkinlik_sorulari/disgrafi6',
    'etkinlik_sorulari/diskalkuli1',
    'etkinlik_sorulari/diskalkuli2',
    'etkinlik_sorulari/diskalkuli3',
    'etkinlik_sorulari/diskalkuli4',
    'etkinlik_sorulari/diskalkuli5',
    'etkinlik_sorulari/diskalkuli6',
    'etkinlik_sorulari/diskalkuli7',
    'etkinlik_sorulari/disleksi1',
    'etkinlik_sorulari/disleksi2',
    'etkinliki_sorulari/disleksi3',
    'etkinlik_sorulari/disleksi4' //buraya da virgül konulur mu bilmiyorum emin olamadım. İki türlü de hata vermiyor çünkü.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Sorulari'),
      ),
      body: ListView.builder(
        itemCount: etkinlikOyunlari.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(etkinlikOyunlari[index]),
            onTap: () {
              Navigator.pushNamed(context, etkinlikOyunlari[index]);
            },
          );
        },
      ),
    );
  }
}
