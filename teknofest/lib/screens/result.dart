import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teknofest/screens/home.dart';
import 'package:teknofest/screens/quiz_play.dart';



class Result extends StatefulWidget {
  final int score;
  final int totalQuestion;
  final int correct;
  final int incorrect;
  final int notAttempted;

  const Result({
    required this.score,
    required this.totalQuestion,
    required this.correct,
    required this.incorrect,
    required this.notAttempted,
   });

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String greeting = "";
  @override
  void initState(){
    super.initState();
    var per = (widget.score/(widget.totalQuestion*20))*100;

    if(per >= 90){
      greeting = "Mükemmel";
    }
    else if(per > 80 && per < 90){
      greeting = "Güzel";
    }
    else if(per > 70 && per < 80){
      greeting = "İyi";
    }
    else{
      greeting = "Daha iyisini yapabilirsin";
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("$greeting"),
            SizedBox(height: 8,),
            Text("Puanın ${widget.score}"),
            SizedBox(height: 8,),
            Text("${widget.correct} Doğru, ${widget.incorrect} Yanlış, ${widget.notAttempted} Boş"),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizPlay() ));
              },
              child: Container(
                padding: EdgeInsets
                .symmetric(vertical: 12,horizontal: 54 ),
                child: Text("Testi tekrar yap",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.blue,
                ) ,
              ),
            ),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage() ));
              },
              child: Container(
                padding: EdgeInsets
                    .symmetric(vertical: 12,horizontal: 54 ),
                child: Text("Anasayfaya dön",style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                ),),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  border: Border.all(color: Colors.blue)
                ) ,
              ),
            )
          ],
        ),
      ),
    );
  }
}