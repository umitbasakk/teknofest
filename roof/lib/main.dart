import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:roof/etkinlik_sorulari/disgrafi1.dart';
import 'package:roof/etkinlik_sorulari/disgrafi2.dart';
import 'package:roof/etkinlik_sorulari/disgrafi3.dart';
import 'package:roof/etkinlik_sorulari/disgrafi4.dart';
import 'package:roof/etkinlik_sorulari/disgrafi5.dart';
import 'package:roof/etkinlik_sorulari/disgrafi6.dart';
import 'package:roof/etkinlik_sorulari/diskalkuli1.dart';
import 'package:roof/etkinlik_sorulari/diskalkuli2.dart';
import 'package:roof/etkinlik_sorulari/diskalkuli3.dart';
import 'package:roof/etkinlik_sorulari/diskalkuli4.dart';
import 'package:roof/etkinlik_sorulari/diskalkuli5.dart';
import 'package:roof/etkinlik_sorulari/diskalkuli6.dart';
import 'package:roof/etkinlik_sorulari/diskalkuli7.dart';
import 'package:roof/etkinlik_sorulari/disleksi1.dart';
import 'package:roof/etkinlik_sorulari/disleksi2.dart';
import 'package:roof/etkinlik_sorulari/disleksi3.dart';
import 'package:roof/etkinlik_sorulari/disleksi4.dart';
import 'package:roof/giris_sorulari/giris_harf_eslestir_disleksi.dart';
import 'package:roof/giris_sorulari/golge_oyunu.dart';
import 'package:roof/giris_sorulari/gorsel_adi.dart';
import 'package:roof/giris_sorulari/ilk_harf.dart';
import 'package:roof/giris_sorulari/mat_hesaplama.dart';
import 'package:roof/giris_sorulari/sayi_oyunu.dart';
import 'package:roof/other_screens/login_screen.dart';
import 'package:roof/other_screens/registiration_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ilk_harf.dart dosyasında rotalar bulunuyor.
// seçenekli oyuna bak. orada da main.dart var
Future<void> main() async {

  //dotenv kütüphanesi ile supabase bağlantısı gerçekleşir. bunun için roof klasörünün altına bakın.
  //.env dosyası varsa ve içinde değerler varsa bir şey yapmanıza gerek yok. Eğer .env dosyası yoksa supabase uygulamasına girin
  //supabase uygulamasında Project settings > API  içerisinde bulunan project url ve project API keys içerisinde bulunan anon ve public ile etiketlenmiş kodu kopyalayıp
  //.env dosyasına yapıştırın. Auth yani oturum açma işlemlerinin ve veritabanının yönetimi supabase üzerinden gerçekleşir. 
  await dotenv.load();
    await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,   
  );

  runApp(const MyApp());
}

//supabase ile ilgili fonksiyonları kullanmak istiyorsanız aşağıdaki tanımlamayı kullanmanız yeterli. Normalde supabase instance tek seferde 
//main üzerinde tanımlanır ve her yerde kullanılır. Yani başk başka sayfalarda Supabase fonksiyonlarını kullanabilmek için tek yapmanız gereken supabase yazmak. supabase kelimesinin üzerine mouse'u getirdiğinizde
//otomatik olarak maini import edecektir
final supabase = Supabase.instance.client;//------------------------------
//--------------------------------------------------------------------
//-----------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teknofest Organizasyonu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {

        //oturum açma işlemlerinin yapıldığı bölüm
        '/' : (context) => const LoginScreen(),
        '/register' : (context) => const RegistrationScreen(),
        '/login' : (context) => const LoginScreen(),

        //giriş sorularının bulunduğu rotalar
        'giris_sorulari/giris_harf_eslestir_disleksi': (context) => const HomePage(),
        'giris_sorulari/golge_oyunu': (context) => const WordShadowMatchGame(),
        'giris_sorulari/gorsel_adi': (context) => const WordFillGame(),
        'giris_sorulari/ilk_harf': (context) => const StartPage(),
        'giris_sorulari/ilk_harf/game': (context) => const FillMissingLetter(),
        'giris_sorulari/ilk_harf/result': (context) => const ResultPage(),
        'giris_sorulari/mat_hesaplama': (context) => const HomePage2(),
        'giris_sorulari/sayi_oyunu': (context) => const DiskalkuliEgitimPage(),

        //etkinlik sorularının bulunduğu rotalar
        'etkinlik_sorulari/disgrafi1': (context) => const PoemPage(),
        'etkinlik_sorulari/disgrafi2': (context) => const KarisikAylar(),
        'etkinlik_sorulari/disgrafi3': (context) => const ColorNamingGame(),
        'etkinlik_sorulari/disgrafi4': (context) => const KarisikRenkler(),
        'etkinlik_sorulari/disgrafi5': (context) => const StartScreen(),
        'etkinlik_sorulari/disgrafi6': (context) => const EmojiQuiz(),
        'etkinlik_sorulari/diskalkuli1': (context) => const ToplamaSayfasi(),
        'etkinlik_sorulari/diskalkuli2': (context) => const CikarmaSayfasi(),
        'etkinlik_sorulari/diskalkuli3': (context) => const MathQuiz(),
        'etkinlik_sorulari/diskalkuli4': (context) => const MathActivity(),
        'etkinlik_sorulari/diskalkuli5': (context) => const YansimaIsaretlemeOyunu(),
        'etkinlik_sorulari/diskalkuli6': (context) => const CountingGame(),
        'etkinlik_sorulari/diskalkuli7': (context) => const PuzzleGameScreen(),
        'etkinlik_sorulari/disleksi1': (context) => const WordMatchingScreen(),
        'etkinlik_sorulari/disleksi2': (context) => const HomeScreen(),
        'etkinliki_sorulari/disleksi3': (context) => const DyslexiaActivityPage(),
        'etkinlik_sorulari/disleksi4': (context) => Disleksi4()


      },
      //home: nigga,
    );
  }
}