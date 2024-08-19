import 'package:flutter/material.dart';
import 'package:roof/giris_sorulari/secenekli_oyun/views/quiz_play.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=> QuizPlay()
                ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical:12,horizontal: 54),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(80),
            ),
            child: Text("Oyuna Başla",style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),),
          ),
        ),
      ),
    );
  }
}
