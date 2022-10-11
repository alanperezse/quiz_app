import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/score.dart';


/// Contains the information for a question
/// where the user needs select one of the
/// provided alternatives.
class MultipleChoiceQuestion extends Question {
  final String _stem;
  final Iterable _choices;
  final num _answer;
  /// User provided answer.
  num? userAnswer;

  /// Immutable list of strings detailing
  /// possible answers to the prompt. Only
  /// one of them is correct.
  Iterable get choices => _choices;
  /// Correct answer.
  num get answer => _answer;

  /// Initializes the question. User answer
  /// must be provided afterwards.
  MultipleChoiceQuestion(this._stem, this._choices, this._answer);

  /// Returns a score of 0/1 or 1/1 depending
  /// whether or not the user answer matches
  /// the correct answer.
  @override
  Score evaluate() {
    var score = userAnswer == _answer ? 1 : 0;
    return Score(score, 1);
  }
  
  /// The prompt to the question.
  @override
  String get stem => _stem;
}