import 'package:quiz_app/models/score.dart';

class QuestionResult {
  final String _stem;
  final String _answer;
  final String? _userAnswer;
  final Score _score;

  get stem => _stem;
  get answer => _answer;
  get userAnswer => _userAnswer;
  get score => _score;

  QuestionResult(this._stem, this._answer, this._userAnswer, this._score);

  @override
  String toString() {
    return {
      'stem': stem,
      'answer': answer,
      'userAnswer': userAnswer,
      'score': '${score.points}/${score.maxPoints}'
    }.toString();
  }
}