import 'package:quiz_app/models/results.dart';
import 'package:quiz_app/models/score.dart';

class QuizResult {
  final List<QuestionResult> _questionResults;
  final Score _score;
  get questionResults => _questionResults;
  get score => _score;
  
  QuizResult(this._questionResults, this._score);
}