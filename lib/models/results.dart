import 'package:quiz_app/models/score.dart';

class QuestionResult {
  final String _stem;
  final String _answer;
  final String? _userAnswer;
  final Score _score;

  String get stem => _stem;
  String get answer => _answer;
  String? get userAnswer => _userAnswer;
  Score get score => _score;

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