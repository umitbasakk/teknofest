import '../model/questionmodel.dart';


List<QuestionModel> getQuestion() {
 List<QuestionModel> questions = [];

 QuestionModel questionModel;

 // İlk soru
 questionModel = QuestionModel(
  question: '_uzdolabı',
  answer: 'b',
  imageUrl: "assets/images/buzdolabi1.jpg" );
 questions.add(questionModel);

 // İkinci soru
 questionModel = QuestionModel(
  question: '_üğüm',
  answer: 'd',
  imageUrl: "assets/images/dugum1.jpg",
 );
 questions.add(questionModel);

 // Üçüncü soru
 questionModel = QuestionModel(
  question: '_ürbün',
  answer: 'd',
  imageUrl: "assets/images/durbun1.jpg",
 );
 questions.add(questionModel);

 // Daha fazla soru eklemek için benzer şekilde devam edebilirsiniz.
 // Örnek:
 questionModel = QuestionModel(
  question: '_ayrak',
  answer: 'b',
  imageUrl: "assets/images/bayrak1.jpg",
 );
 questions.add(questionModel);

 return questions;
}