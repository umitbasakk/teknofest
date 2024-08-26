import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:teknofest/screens/MessageHandler.dart';
import 'package:teknofest/screens/giris_sorulari_screen.dart';
import 'package:teknofest/screens/home_page.dart';
import 'package:teknofest/supabase/auth.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 49, 73),
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                
                if(email == "" || password == ""){
                    ResultHandler(context,ContentType.failure ,"Oh Snap!", "Kullanıcı adı veya şifre boş olamaz");
                    return;
                }
                
                Result<String> result = await signUp(email, password);

                if(result.error != null){
                    ResultHandler(context, ContentType.failure,"Oh Snap!", result.error!);                  
                }else{
                    ResultHandler(context,ContentType.success, "Success", "Başarıyla kayıt oldunuz. Yönlendiriliyorsunuz...");
                    Future.delayed(Duration(seconds: 2),()=>{
                       Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    )
                    });
                }
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
