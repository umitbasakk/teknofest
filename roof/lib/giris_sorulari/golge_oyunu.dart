
import 'package:flutter/material.dart';

class WordShadowMatchGame extends StatefulWidget {
  const WordShadowMatchGame({super.key});

  @override
  _WordShadowMatchGameState createState() => _WordShadowMatchGameState();
}//setState metodu ile arayüzün yeniden çizilmesini sağlar.
//listeleri sıraladığımız class. yüklenen fotoğraf sırası images dosyasında aynı sırada olmalı.
class _WordShadowMatchGameState extends State<WordShadowMatchGame> {
  final List<String> words = ['Ördek', 'Şemsiye', 'Şapka', 'Davul', 'Mantar', 'Araba'];
  final List<String> shadowImages = [
    /*lib dosyası gibi sadece proje içinde olan başka bir bulunan dosyanın alt dosyası olmayan
    assets isimli bir dosya açılır.Bu dosya içinde images dosyası açılır.
    İnternetten bulduğumuz .png uzantılı resimleri images dosyasının içine indirilir.
    Resimler kod içeriğinin sırası ile sıralanmış olmalı.*/
    'assets/images/duck.png',
    'assets/images/umbrella.png',
    'assets/images/hat.png',
    'assets/images/drum.png',
    'assets/images/mushroom.png',
    'assets/images/car.png',
  ]; // Basit gölge resimleri
  List<String> shuffledShadowImages = [];/*shuffledShadowImages adında bir
  liste oluşturur ve başlangıçta boş bir liste olarak tanımlar. Bu liste,
  gölgelerin resim dosyalarının yolunu içerecektir. shuffledShadowImages listesi,
  shadowImages listesinden türetilmiş ve karıştırılmış bir kopyayı tutmak için kullanılır.
  Bu şekilde, her oyun başladığında gölgelerin sırası rastgele değiştirilmiş olur.*/
  String? selectedWord;//Kullanıcı bir kelimeyi seçtiğinde bu değişken bu kelimeyi tutar.
  String? selectedShadow;//bu da seçilen gölgeyi tutar.
  final Map<String, String> matches = {};//matches, bir Map objesidir ve eşleşen kelimeler ile gölgeleri tutmak için kullanılır.

  @override
  void initState() {
    super.initState();
    shuffledShadowImages = List.from(shadowImages)..shuffle();
    /*shadowImages listesinin bir kopyası olarak oluşturulur.
    Daha sonra bu kopya liste karıştırılır.*/
  }

  void selectWord(String word) {//kelime seçimi yapıp veriyi tutmayı sağlıyo.
    setState(() {
      selectedWord = word;
      if (selectedShadow != null) {
        checkMatch();
      }
    });
  }

  void selectShadow(String shadow) {//gölge seçimi yapmamızı ve seçimi tutmayı sağlıyo.
    setState(() {
      selectedShadow = shadow;
      if (selectedWord != null) {
        checkMatch();
      }
    });
  }

  void checkMatch() {/*kullanıcının seçtiği kelime ve gölge resmi arasında
   eşleşip eşleşmediğini kontrol eder ve buna göre durumu günceller.*/
    if (shadowImages[words.indexOf(selectedWord!)] == selectedShadow) {
      setState(() {
        matches[selectedWord!] = selectedShadow!;
        selectedWord = null;
        selectedShadow = null;
      });
    } else {
      setState(() {
        matches[selectedWord!] = 'wrong';
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            matches.remove(selectedWord!);
          });
        });
        selectedWord = null;
        selectedShadow = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//Scaffold widget'ı, temel materyal tasarımı ve uygulamanın ana iskeletini sağlar.
      appBar: AppBar(//uygulamada AppBar içinde "Kelimeleri Gölgeleriyle Eşleştirme" başlığı bulunur.
        title: const Text('Kelimeleri Gölgeleriyle Eşleştirme'),
      ),
      body: Padding(//içeriğin etrafına 16 birimlik iç boşluk ekler.
        padding: const EdgeInsets.all(16.0),
        child: Column(//Sütun şeklindeki bir düzen sağlar.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(//Ekranda kullanılabilir tüm dikey alanı kaplar. İçerisinde bir Column bulunur.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(words.length, (index) {//List.generate  her kelime ve gölge resmi için dinamik olarak bir Row oluşturulur.
                  String word = words[index];
                  String shadow = shuffledShadowImages[index];
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector( //kelimelere dokunulduğunda selectWord fonksiyonunu tetikler.
                          onTap: () => selectWord(word),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            color: matches[word] == 'wrong'
                                ? Colors.red //yanlışsa kırmızı
                                : (matches[word] != null
                                ? Colors.green//doğruysa yeşil
                                : (selectedWord == word ? Colors.blue : Colors.grey[300])),//sadece seçim sırasında mavi
                            child: Text(
                              word,
                              style: const TextStyle(fontSize: 20),//fontu 20
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50), // Kelimeler ve gölgeler arasındaki boşluk
                      Expanded(
                        child: GestureDetector(
                          onTap: () => selectShadow(shadow),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            color: matches.containsValue(shadow)
                                ? Colors.green
                                : (selectedShadow == shadow ? Colors.blue : Colors.grey[300]),
                            child: Image.asset(
                              shadow,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
