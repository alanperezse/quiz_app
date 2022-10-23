import 'dart:convert';
import 'package:http/http.dart';
import 'package:quiz_app/models/fill_in_question.dart';
import 'package:quiz_app/models/multiple_choice_question.dart';
import 'package:quiz_app/models/question.dart';
import '../models/login_response.dart';

/// Utility class responsible for parsing the data from the server
class APIDecoder {
  /// Parses the response when authenticating a user.
  LoginResponse decodeAuthResponse(Response response) {
    var body = json.decode(response.body);
    if (body['response']) return LoginResponse(true, null);

    return LoginResponse(body['response'], body['reason']);
  }

  /// Parses the list of questions from a quiz in the server. Returns null
  /// if the body could not be parsed.
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
            question['figure'],
            question['option'],
            question['answer']
          )
        ); 
      } else { // Fill in question
        questions.add(
          FillInQuestion(
            question['stem'],
            question['figure'],
            question['answer']
          )
        );
      }
    }

    return questions;
  }
}