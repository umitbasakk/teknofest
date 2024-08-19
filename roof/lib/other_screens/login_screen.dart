import 'package:flutter/material.dart';
import 'package:roof/other_screens/etkinlik_sorulari_screen.dart';
import 'package:roof/supabase/auth.dart';
import 'giris_sorulari_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _userHasNotCompletedGirisSorulari = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                // Kullanıcı giriş yapmaya çalışıyor
                await signIn(email, password);

                // Girişten sonra kullanıcı verilerini kontrol et
                _checkUserProgress();

                if (_userHasNotCompletedGirisSorulari) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GirisSorulariScreen(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EtkinlikSorulariListScreen(),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _checkUserProgress() {
    // Burada Supabase veya başka bir yöntemle kullanıcı verilerini kontrol et
    // Örneğin, tamamlanan oyunları kontrol et

    // Örneğin:
    setState(() {
      _userHasNotCompletedGirisSorulari = false; // Duruma göre ayarla
    });
  }
}
