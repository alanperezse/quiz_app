import 'dart:convert';
import 'package:http/http.dart';
import 'package:quiz_app/models/fill_in_question.dart';
import 'package:quiz_app/models/multiple_choice_question.dart';
import 'package:quiz_app/models/question.dart';
import '../models/login_response.dart';

class APIDecoder {
  LoginResponse decodeAuthResponse(Response response) {
    var body = json.decode(response.body);
    if (body['response']) return LoginResponse(true, null);

    return LoginResponse(body['response'], body['reason']);
  }

  List<Question>? decodeQuiz(Response response) {
    var body = json.decode(response.body);
    if (!body['response']) {
      return null;
    }

    List<Question> questions = [];

    for (var question in body['quiz']['question']) {
      if(question['type'] == 1) { // Multiple choide question
        questions.add(
          MultipleChoiceQuestion(
            question['stem'],
            question['option'],
            question['answer']
          )
        ); 
      } else { // Fill in question
        questions.add(
          FillInQuestion(
            question['stem'],
            question['answer']
          )
        );
      }
    }

    return questions;
  }
}