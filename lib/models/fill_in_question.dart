import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/results.dart';
import 'package:quiz_app/models/score.dart';


/// Contains the information for a question
/// where the user needs to provide a string
/// to fill the missing prompt.
class FillInQuestion extends Question{
  final String _stem;
  final Iterable _answer;
  /// User provided answer.
  String? userAnswer;

  /// Initializes the question. User answer
  /// must be provided afterwards.
  FillInQuestion(this._stem, this._answer);

  /// Immutable list of strings of correct
  /// answers.
  get answer => _answer;
  /// Returns a score of 0/1 or 1/1 depending
  /// whether or not the user answer matches
  /// any of the acceptable answers.
  @override
  QuestionResult evaluate() {
    var points = 0;

    for(var ans in answer) {
      if (ans == (userAnswer ?? '')) {
        points = 1;
        break;
      }
    }

    var score = Score(points, 1);

    return QuestionResult(
      _stem,
      answer,
      userAnswer,
      score
    );
  }
  
  /// The prompt to the question.
  @override
  String get stem => _stem;
}