class QuestionModel{
late String question;
late String answer;
late String imageUrl;

QuestionModel({required this.question,required this.answer,required this.imageUrl});

void setQuestion(String getQuestion){
  question = getQuestion;
}
void setAnswer(String getAnswer){
  answer = getAnswer;

}
void setimageUrl(String getImageUrl){
  imageUrl= getImageUrl;
}
String getQuestion(){
  return question;
}
String getAnswer(){
  return answer;
}
String getImageUrl(){
  return imageUrl;
}


}